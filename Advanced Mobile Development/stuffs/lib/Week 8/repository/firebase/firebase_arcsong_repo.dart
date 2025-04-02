import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:stuffs/Week%208/dto/arcsong_dto.dart';

import 'package:stuffs/Week%208/models/arcsong.dart';
import 'package:stuffs/Week%208/repository/arcsong_repo.dart';
import 'package:stuffs/Week%208/schemas/arcsong_creation_schema.dart';
import 'package:stuffs/Week%208/utils/async_value.dart';
import 'package:uuid/uuid.dart';

class FirebaseArcsongRepository extends ArcsongRepository {
  static const String songsCollection = "songlist";
  static String allSongsUrl = '$baseUrl/$songsCollection.json';
  static const Uuid uuid = Uuid();

  AsyncValue<List<Arcsong>> arcsongCache = AsyncValue.initial();

  static String get baseUrl {
    String? url = dotenv.env['FIREBASE_URL'];
    if (url == null) throw Exception('Environment variable not found');
    return url;
  }

  FirebaseArcsongRepository() {}

  Future<void> finishLoading() async {
    while (true) {
      if (!arcsongCache.isLoading) break;
      await Future.delayed(const Duration(milliseconds: 500), () {});
    }
  }

  Future<void> syncArcsongs() async {
    if (arcsongCache.isLoading) return;
    try {
      arcsongCache = AsyncValue.loading();
      Uri uri = Uri.parse(allSongsUrl);
      final http.Response response = await http.get(uri);
      if (response.statusCode != HttpStatus.ok &&
          response.statusCode != HttpStatus.created) {
        throw Exception('Failed to load');
      }
      final data = json.decode(response.body) as Map<String, dynamic>?;

      if (data == null) {
        arcsongCache = AsyncValue.empty([]);
        return;
      }
      List<Arcsong> parsedData = data.entries
          .map((entry) => ArcsongDto.fromJson(entry.key, entry.value))
          .toList();

      arcsongCache = AsyncValue.success(parsedData);
    } catch (e) {
      arcsongCache = AsyncValue.error(e);
    }
  }

  @override
  Future<List<Arcsong>> getArcsongs() async {
    await finishLoading();

    if (!arcsongCache.isError) return arcsongCache.data!;

    throw Exception(arcsongCache.error);
  }

  @override
  Future<Arcsong> newArcsong(ArcsongCreationSchema newArcsong) async {
    await finishLoading();
    if (arcsongCache.isError) throw Exception();
    final newArcsongData = newArcsong.toJson();

    String tempKey = uuid.v4();
    uploadAndSync(tempKey, newArcsongData);

    Arcsong arcsong = ArcsongDto.fromJson(tempKey, newArcsongData);
    arcsongCache.data!.add(arcsong);

    return arcsong;
  }

  Future<void> uploadAndSync(
      String tempKey, Map<String, dynamic> arcsongData) async {
    Uri uri = Uri.parse(allSongsUrl);
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(arcsongData),
    );

    if (response.statusCode != HttpStatus.ok) {
      arcsongCache.data!
          .removeWhere((arcsong) => arcsong.firebaseKey == tempKey);
      syncArcsongs();
      throw Exception('Failed to add Arcsong');
    }

    final String newKey = json.decode(response.body)['name'];

    arcsongCache.data!.removeWhere((arcsong) => arcsong.firebaseKey == tempKey);
    arcsongCache.data!.add(ArcsongDto.fromJson(newKey, arcsongData));
  }
}

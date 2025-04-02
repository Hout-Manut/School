// REPOSITORY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'async_value.dart';

// REPOS
abstract class PancakeRepository {
  Future<Pancake> addPancake({required String color, required double price});
  Future<List<Pancake>> getPancakes();
}

class FirebasePancakeRepository extends PancakeRepository {
  static const String baseUrl = 'https://flutter-week-8-61f38-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String songsCollection = "songlist";
  static const String allSongsUrl = '$baseUrl/$songsCollection.json';

  @override
  Future<Pancake> addPancake({required String color, required double price}) async {
    Uri uri = Uri.parse(allSongsUrl);

    // Create a new data
    final newPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newPancakeData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Pancake(id: newId, color: color, price: price);
  }

  @override
  Future<List<Pancake>> getPancakes() async {
    Uri uri = Uri.parse(allSongsUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries.map((entry) => PancakeDto.fromJson(entry.key, entry.value)).toList();
  }
}

class MockPancakeRepository extends PancakeRepository {
  final List<Pancake> pancakes = [];

  @override
  Future<Pancake> addPancake({required String color, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      Pancake newPancake = Pancake(id: "0", color: color, price: 12);
      pancakes.add(newPancake);
      return newPancake;
    });
  }

  @override
  Future<List<Pancake>> getPancakes() {
    return Future.delayed(Duration(seconds: 1), () => pancakes);
  }
}

// MODEL & DTO
class PancakeDto {
  static Pancake fromJson(String id, Map<String, dynamic> json) {
    return Pancake(id: id, color: json['color'], price: json['price']);
  }

  static Map<String, dynamic> toJson(Pancake pancake) {
    return {'name': pancake.color, 'price': pancake.price};
  }
}

// MODEL
class Pancake {
  final String id;
  final String color;
  final double price;

  Pancake({required this.id, required this.color, required this.price});

  @override
  bool operator ==(Object other) {
    return other is Pancake && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

// PROVIDER
class Pancakeprovider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;

  Pancakeprovider(this._repository) {
    fetchUsers();
  }

  bool get isLoading => pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData => pancakesState != null && pancakesState!.state == AsyncValueState.success;

  void fetchUsers() async {
    try {
      // 1- loading state
      pancakesState = AsyncValue.loading();
      notifyListeners();

      // 2 - Fetch users
      pancakesState = AsyncValue.success(await _repository.getPancakes());

      print("SUCCESS: list size ${pancakesState!.data!.length.toString()}");

      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addPancake(String color, double price) async {
    // 1- Call repo to add
    _repository.addPancake(color: color, price: price);

    // 2- Call repo to fetch
    fetchUsers();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) {
    final Pancakeprovider pancakeProvider = context.read<Pancakeprovider>();
    pancakeProvider.addPancake("blue", 3.1);
  }

  @override
  Widget build(BuildContext context) {
    final pancakeProvider = Provider.of<Pancakeprovider>(context);

    Widget content = Text('');
    if (pancakeProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (pancakeProvider.hasData) {
      List<Pancake> pancakes = pancakeProvider.pancakesState!.data!;

      if (pancakes.isEmpty) {
        content = Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: pancakes.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Text(pancakes[index].color),
                subtitle: Text("${pancakes[index].price}"),
                trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => {}),
              ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: () => _onAddPressed(context), icon: const Icon(Icons.add))],
      ),
      body: Center(child: content),
    );
  }
}

// 5 - MAIN
void main() async {
  // 1 - Create repository
  final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  // 2-  Run app
  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}

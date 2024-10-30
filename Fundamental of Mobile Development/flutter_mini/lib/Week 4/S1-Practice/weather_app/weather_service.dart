import 'dart:convert';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'cities.dart';
import 'exceptions.dart';

class WeatherService {
  final String _apiKey = dotenv.env["1FIZcFAB7TAlN0yCefXy2QNa7HOFx6xX"] ?? "";
  final String _endpoint = "https://api.tomorrow.io/v4/timelines";
  final Map<Cities, Map<String, dynamic>> _cache = HashMap();

  Map<String, String> getTimes() {
    DateTime currentTime = DateTime.now();
    DateTime startOfDay =
        DateTime(currentTime.year, currentTime.month, currentTime.day);

    DateTime fiveDaysLater = currentTime.add(Duration(days: 5));

    return {
      "startTime": startOfDay.toUtc().toIso8601String(),
      "endTime": fiveDaysLater.toUtc().toIso8601String(),
      "timezone": currentTime.timeZoneName,
    };
  }

  Future<List<Map<String, dynamic>>> fetchWeatherData(Cities city) async {
    final currentTimestamp = DateTime.now();

    if (_cache.containsKey(city)) {
      final cacheEntry = _cache[city];
      final timestamp = cacheEntry?["timestamp"] as DateTime;

      // Check if the cached data is older than 30 minutes
      if (currentTimestamp.difference(timestamp).inMinutes < 30) {
        return cacheEntry!["data"];
      }
    }
    final data = await _fetch(city.name);
    _cache[city] = {
      "timestamp": currentTimestamp,
      "data": data,
    };
    return data;
  }

  Future<List<Map<String, dynamic>>> _fetch(String cityName) async {
    final Uri url = Uri.parse("$_endpoint?apikey=$_apiKey");
    final Map<String, String> time = getTimes();

    final Map<String, dynamic> payload = {
      "location": "11.5564,104.9282",
      "fields": [
        "cloudCover",
        "humidity",
        "precipitationProbability",
        "rainIntensity",
        "temperature",
        "temperatureApparent",
        "windDirection",
        "windGust",
        "windSpeed",
      ],
      "units": "metric",
      "timesteps": ["1h"],
      "startTime": time["startTime"],
      "endTime": time["endTime"],
      "timezone": "auto"
    };

    final Map<String, String> headers = {
      "accept": "application/json",
      "Accept-Encoding": "gzip",
      "content-type": "application/json"
    };

    final http.Response response;

    try {
      response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['timelines'][0]['intervals'];
    } else {
      throw HttpStatusCodes.fromCode(response.statusCode) ??
          Exception("Failed with status: ${response.statusCode}");
    }
  }
}

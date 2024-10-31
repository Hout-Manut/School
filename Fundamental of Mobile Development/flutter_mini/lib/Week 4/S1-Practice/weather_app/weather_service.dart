import 'dart:convert';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'enums.dart';
import 'weather_data.dart';

class WeatherService {
  final String _apiKey = dotenv.env["TOMORROW_API_KEY"] ?? "";
  final String _endpoint = "https://api.tomorrow.io/v4/timelines";
  final String _realtimeEndpoint = "https://api.tomorrow.io/v4/weather/realtime";

  // For testing
  // final String _endpoint = "http://172.20.160.1:5000/mock-endpoint";
  final Map<Cities, Map<String, dynamic>> _cache = HashMap();

  Map<String, String> getTimes() {
    DateTime currentTime = DateTime.now();
    DateTime startOfYesterday = currentTime.subtract(Duration(hours: 23));

    DateTime fiveDaysLater = currentTime.add(Duration(days: 4, hours: 23));

    return {
      "startTime": startOfYesterday.toUtc().toIso8601String(),
      "endTime": fiveDaysLater.toUtc().toIso8601String(),
      "timezone": currentTime.timeZoneName,
    };
  }

  Future<WeatherData> fetchWeatherData(Cities city, void Function(String) messageSetter) async {
    final currentTimestamp = DateTime.now();

    if (_cache.containsKey(city)) {
      final cacheEntry = _cache[city];
      final timestamp = cacheEntry?["timestamp"] as DateTime;

      // Check if the cached data is older than 30 minutes
      if (currentTimestamp.difference(timestamp).inMinutes < 30) {
        return cacheEntry!["data"];
      }
    }
    final timelineData = await _fetchTimeline(city, messageSetter);
    final realtimeData = await _fetchRealtime(city, messageSetter);

    WeatherData newDate = WeatherData.fromJson(timelineData, realtimeData);
    _cache[city] = {
      "timestamp": currentTimestamp,
      "data": newDate
    };
    return newDate;
  }

  Future<Map<String, dynamic>> _fetchRealtime(Cities city, void Function(String) messageSetter) async {
    final Uri url = Uri.parse("$_realtimeEndpoint?location=${city.latLon.replaceAll(",", "%2C")}&apikey=$_apiKey");
    final Map<String, String> headers = {
      "accept": "application/json",
    };
    final http.Response response;

    try {
      response = await http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      messageSetter("Failed to connect to tomorrow.io");
      throw Exception("Something went wrong: $e");
    }
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      if (response.statusCode == 429) messageSetter("Got rate limited lol");
      // ignore: avoid_print
      print(response.body);
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> _fetchTimeline(Cities city, void Function(String) messageSetter) async {
    messageSetter("");
    final Uri url = Uri.parse("$_endpoint?apikey=$_apiKey");
    final Map<String, String> time = getTimes();

    final Map<String, dynamic> payload = {
      "location": city.latLon,
      "fields": [
        "cloudCover",
        "humidity",
        "precipitationProbability",
        "rainIntensity",
        "temperature",
        "temperatureMax",
        "temperatureMin",
        "temperatureApparent",
        "windDirection",
        "windGust",
        "windSpeed",
      ],
      "units": "metric",
      "timesteps": ["1h", "1d"],
      "startTime": time["startTime"],
      "endTime": time["endTime"],
      "timezone": city.timezone,
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
      messageSetter("Failed to connect to tomorrow.io");
      throw Exception("Something went wrong: $e");
    }
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      if (response.statusCode == 429) messageSetter("Got rate limited lol");
      // ignore: avoid_print
      print(response.body);
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }
}

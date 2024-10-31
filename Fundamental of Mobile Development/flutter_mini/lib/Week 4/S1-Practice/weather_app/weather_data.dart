import 'package:intl/intl.dart';
import 'enums.dart';

class WeatherData {
  final List<Timeline> timelines;

  WeatherData({required this.timelines});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var timelinesJson = json['data']['timelines'] as List;
    List<Timeline> timelinesList =
        timelinesJson.map((e) => Timeline.fromJson(e)).toList();

    return WeatherData(timelines: timelinesList);
  }

  Timeline get dayIntervals => timelines[0];

  WeatherInterval getIntervalDataByDay(SelectedDay day) {
    try {
      switch (day) {
        case SelectedDay.beforeYesterday:
          return dayIntervals.intervals[0];
        case SelectedDay.yesterday:
          return dayIntervals.intervals[1];
        case SelectedDay.today:
          return dayIntervals.intervals[2];
        case SelectedDay.tomorrow:
          return dayIntervals.intervals[3];
        case SelectedDay.thirdDay:
          return dayIntervals.intervals[4];
        case SelectedDay.fourthDay:
          return dayIntervals.intervals[5];
        case SelectedDay.fifthDay:
          return dayIntervals.intervals[6];
      }
    } catch (e) {
      // Catch index errors specifically and return a default WeatherInterval
      if (e is RangeError) {
        return WeatherInterval(
          startTime: DateTime.now().toString(),
          values: Values(
            cloudCover: 0.0,
            humidity: 0.0,
            precipitationProbability: 0.0,
            rainIntensity: 0.0,
            temperature: 0.0,
            temperatureMax: 0.0,
            temperatureMin: 0.0,
            temperatureApparent: 0.0,
            windDirection: 0.0,
            windGust: 0.0,
            windSpeed: 0.0,
          ),
        );
      } else {
        rethrow; // Re-throw if it’s a different exception
      }
    }
  }


WindDirection getWindDirection(double windDirection) {
    if (windDirection >= 337.5 || windDirection < 22.5) {
      return WindDirection.n;
    } else if (windDirection >= 22.5 && windDirection < 67.5) {
      return WindDirection.ne;
    } else if (windDirection >= 67.5 && windDirection < 112.5) {
      return WindDirection.e;
    } else if (windDirection >= 112.5 && windDirection < 157.5) {
      return WindDirection.se;
    } else if (windDirection >= 157.5 && windDirection < 202.5) {
      return WindDirection.s;
    } else if (windDirection >= 202.5 && windDirection < 247.5) {
      return WindDirection.sw;
    } else if (windDirection >= 247.5 && windDirection < 292.5) {
      return WindDirection.w;
    } else {
      return WindDirection.nw;
    }
  }

  String getDayStringFromData(
      SelectedDay selectedDay, WeatherInterval dayData) {
    String suffix = "";

    if (selectedDay.i == 1) {
      suffix = "Yesterday, ";
    } else if (selectedDay.i == 2) {
      suffix = "Today, ";
    } else if (selectedDay.i == 3) {
      suffix = "Tomorrow, ";
    }
    String dateStr = dayData.startTime;
    DateTime date = DateTime.parse(dateStr);

    DateFormat formatter = DateFormat('EEEE, MMM d');
    return "$suffix${formatter.format(date)}";
  }

  String getWeatherDescription(Values weatherData) {
    double cloudCover = weatherData.cloudCover;
    double precipitationProbability = weatherData.precipitationProbability;
    double rainIntensity = weatherData.rainIntensity;
    double windSpeed = weatherData.windSpeed;
    // double temperature = weatherData["temperature"] ?? 0.0;

    // Define conditions
    bool isRainy = precipitationProbability > 50 && rainIntensity > 0;
    bool isCloudy = cloudCover > 50;
    bool isSunny = cloudCover < 20 && precipitationProbability < 20;
    bool isWindy = windSpeed > 20; // Arbitrary threshold for windy conditions

    // Return descriptions based on conditions
    if (isRainy) {
      return "Rainy";
    } else if (isCloudy) {
      return "Cloudy";
    } else if (isSunny) {
      return "Sunny";
    } else if (isWindy) {
      return "Windy";
    } else {
      return "Clear";
    }
  }
}

class Timeline {
  final String timestep;
  final String startTime;
  final String endTime;
  final List<WeatherInterval> intervals;

  Timeline({
    required this.timestep,
    required this.startTime,
    required this.endTime,
    required this.intervals,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    var intervalsJson = json['intervals'] as List;
    List<WeatherInterval> intervalsList =
        intervalsJson.map((e) => WeatherInterval.fromJson(e)).toList();

    return Timeline(
      timestep: json['timestep'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      intervals: intervalsList,
    );
  }
}

class WeatherInterval {
  final String startTime;
  final Values values;

  WeatherInterval({
    required this.startTime,
    required this.values,
  });

  factory WeatherInterval.fromJson(Map<String, dynamic> json) {
    return WeatherInterval(
      startTime: json['startTime'],
      values: Values.fromJson(json['values']),
    );
  }
}

class Values {
  final double cloudCover;
  final double humidity;
  final double precipitationProbability;
  final double rainIntensity;
  final double temperature;
  final double temperatureMax;
  final double temperatureMin;
  final double temperatureApparent;
  final double windDirection;
  final double windGust;
  final double windSpeed;

  Values({
    required this.cloudCover,
    required this.humidity,
    required this.precipitationProbability,
    required this.rainIntensity,
    required this.temperature,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.temperatureApparent,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      cloudCover: json['cloudCover']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toDouble() ?? 0.0,
      precipitationProbability:
          json['precipitationProbability']?.toDouble() ?? 0.0,
      rainIntensity: json['rainIntensity']?.toDouble() ?? 0.0,
      temperature: json['temperature']?.toDouble() ?? 0.0,
      temperatureMax: json['temperatureMax']?.toDouble() ?? 0.0,
      temperatureMin: json['temperatureMin']?.toDouble() ?? 0.0,
      temperatureApparent: json['temperatureApparent']?.toDouble() ?? 0.0,
      windDirection: json['windDirection']?.toDouble() ?? 0.0,
      windGust: json['windGust']?.toDouble() ?? 0.0,
      windSpeed: json['windSpeed']?.toDouble() ?? 0.0,
    );
  }
}

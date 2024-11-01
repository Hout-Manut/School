import 'package:intl/intl.dart';
import 'enums.dart';

class WeatherData {
  final List<Timeline> timelines;
  final Values realtime;

  WeatherData({required this.timelines, required this.realtime});

  factory WeatherData.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> realtimeData) {
    var timelinesJson = json['data']['timelines'] as List;
    List<Timeline> timelinesList =
        timelinesJson.map((e) => Timeline.fromJson(e)).toList();

    Values realtimeValue = Values.override(
        realtimeData["data"]["values"], timelinesList[0].intervals[2].values);

    return WeatherData(timelines: timelinesList, realtime: realtimeValue);
  }

  Timeline get dayIntervals => timelines[0];

  Values getValueDataByDay(SelectedDay day) {
    try {
      switch (day) {
        case SelectedDay.beforeYesterday:
          return dayIntervals.intervals[0].values;
        case SelectedDay.yesterday:
          return dayIntervals.intervals[1].values;
        case SelectedDay.today:
          return realtime;
        case SelectedDay.tomorrow:
          return dayIntervals.intervals[3].values;
        case SelectedDay.thirdDay:
          return dayIntervals.intervals[4].values;
        case SelectedDay.fourthDay:
          return dayIntervals.intervals[5].values;
        case SelectedDay.fifthDay:
          return dayIntervals.intervals[6].values;
      }
    } catch (e) {
      if (e is RangeError) {
        return Values.empty();
      } else {
        rethrow;
      }
    }
  }

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
      if (e is RangeError) {
        return WeatherInterval.empty();
      } else {
        rethrow;
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

  WeatherCondition getWeatherDescription(Values weatherData) {
    double cloudCover = weatherData.cloudCover;
    double precipitationProbability = weatherData.precipitationProbability;
    double rainIntensity = weatherData.rainIntensity;
    double windSpeed = weatherData.windSpeed;

    // Define conditions
    bool isDrizzle = precipitationProbability > 50 &&
        rainIntensity > 0 &&
        rainIntensity < 2.5;
    bool isRainy = precipitationProbability > 50 && rainIntensity >= 2.5;
    bool isOvercast = cloudCover > 90;
    bool isCloudy = cloudCover > 50 && cloudCover <= 90;
    bool isPartlyCloudy = cloudCover > 20 && cloudCover <= 50;
    bool isWindy = windSpeed > 20; // Arbitrary threshold for windy conditions
    // bool isSunny = cloudCover <= 20 && precipitationProbability < 20;

    // Return descriptions based on conditions
    if (isDrizzle) {
      return WeatherCondition.drizzle;
    } else if (isRainy) {
      return WeatherCondition.rainy;
    } else if (isOvercast) {
      return WeatherCondition.overcast;
    } else if (isCloudy) {
      return WeatherCondition.cloudy;
    } else if (isPartlyCloudy) {
      return WeatherCondition.partlyCloudy;
    } else if (isWindy) {
      return WeatherCondition.windy;
    } else {
      return WeatherCondition.sunny;
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

  WeatherInterval.empty()
      : startTime = DateTime.now().toString(),
        values = Values.empty();

  factory WeatherInterval.fromJson(Map<String, dynamic> json) {
    return WeatherInterval(
      startTime: json['startTime'],
      values: Values.fromJson(json['values']),
    );
  }
}

class Values {
  final double cloudBase;
  final double cloudCeiling;
  final double cloudCover;
  final double dewPoint;
  final double freezingRainIntensity;
  final double humidity;
  final double precipitationProbability;
  final double pressureSurfaceLevel;
  final double rainIntensity;
  final double sleetIntensity;
  final double snowIntensity;
  final double temperature;
  final double temperatureApparent;
  final double uvHealthConcern;
  final double uvIndex;
  final double visibility;
  final double weatherCode;
  final double windDirection;
  final double windGust;
  final double windSpeed;
  final double temperatureMax;
  final double temperatureMin;

  Values({
    required this.cloudBase,
    required this.cloudCeiling,
    required this.cloudCover,
    required this.dewPoint,
    required this.freezingRainIntensity,
    required this.humidity,
    required this.precipitationProbability,
    required this.pressureSurfaceLevel,
    required this.rainIntensity,
    required this.sleetIntensity,
    required this.snowIntensity,
    required this.temperature,
    required this.temperatureApparent,
    required this.uvHealthConcern,
    required this.uvIndex,
    required this.visibility,
    required this.weatherCode,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
    required this.temperatureMax,
    required this.temperatureMin,
  });

  factory Values.override(Map<String, dynamic> json, Values backup) {
    return Values(
      cloudCover: json['cloudCover']?.toDouble() ?? backup.cloudCover,
      humidity: json['humidity']?.toDouble() ?? backup.humidity,
      precipitationProbability: json['precipitationProbability']?.toDouble() ??
          backup.precipitationProbability,
      rainIntensity: json['rainIntensity']?.toDouble() ?? backup.rainIntensity,
      temperature: json['temperature']?.toDouble() ?? backup.temperature,
      temperatureMax:
          json['temperatureMax']?.toDouble() ?? backup.temperatureMax,
      temperatureMin:
          json['temperatureMin']?.toDouble() ?? backup.temperatureMin,
      temperatureApparent:
          json['temperatureApparent']?.toDouble() ?? backup.temperatureApparent,
      windDirection: json['windDirection']?.toDouble() ?? backup.windDirection,
      windGust: json['windGust']?.toDouble() ?? backup.windGust,
      windSpeed: json['windSpeed']?.toDouble() ?? backup.windSpeed,
      cloudBase: json['cloudBase']?.toDouble() ?? backup.cloudBase,
      cloudCeiling: json['cloudCeiling']?.toDouble() ?? backup.cloudCeiling,
      dewPoint: json['dewPoint']?.toDouble() ?? backup.dewPoint,
      freezingRainIntensity: json['freezingRainIntensity']?.toDouble() ??
          backup.freezingRainIntensity,
      pressureSurfaceLevel: json['pressureSurfaceLevel']?.toDouble() ??
          backup.pressureSurfaceLevel,
      sleetIntensity:
          json['sleetIntensity']?.toDouble() ?? backup.sleetIntensity,
      snowIntensity: json['snowIntensity']?.toDouble() ?? backup.snowIntensity,
      uvHealthConcern:
          json['uvHealthConcern']?.toDouble() ?? backup.uvHealthConcern,
      uvIndex: json['uvIndex']?.toDouble() ?? backup.uvIndex,
      visibility: json['visibility']?.toDouble() ?? backup.visibility,
      weatherCode: json['weatherCode']?.toDouble() ?? backup.weatherCode,
    );
  }

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
      cloudBase: json['cloudBase']?.toDouble() ?? 0.0,
      cloudCeiling: json['cloudCeiling']?.toDouble() ?? 0.0,
      dewPoint: json['dewPoint']?.toDouble() ?? 0.0,
      freezingRainIntensity: json['freezingRainIntensity']?.toDouble() ?? 0.0,
      pressureSurfaceLevel: json['pressureSurfaceLevel']?.toDouble() ?? 0.0,
      sleetIntensity: json['sleetIntensity']?.toDouble() ?? 0.0,
      snowIntensity: json['snowIntensity']?.toDouble() ?? 0.0,
      uvHealthConcern: json['uvHealthConcern']?.toDouble() ?? 0.0,
      uvIndex: json['uvIndex']?.toDouble() ?? 0.0,
      visibility: json['visibility']?.toDouble() ?? 0.0,
      weatherCode: json['weatherCode']?.toDouble() ?? 0.0,
    );
  }
  Values.empty()
      : cloudCover = 0.0,
        humidity = 0.0,
        precipitationProbability = 0.0,
        rainIntensity = 0.0,
        temperature = 0.0,
        temperatureMax = 0.0,
        temperatureMin = 0.0,
        temperatureApparent = 0.0,
        windDirection = 0.0,
        windGust = 0.0,
        windSpeed = 0.0,
        cloudBase = 0.0,
        cloudCeiling = 0.0,
        dewPoint = 0.0,
        freezingRainIntensity = 0.0,
        pressureSurfaceLevel = 0.0,
        sleetIntensity = 0.0,
        snowIntensity = 0.0,
        uvHealthConcern = 0.0,
        uvIndex = 0.0,
        visibility = 0.0,
        weatherCode = 0.0;
}

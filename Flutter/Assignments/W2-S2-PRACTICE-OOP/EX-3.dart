class Duration {
  late final double _milliseconds;

  Duration({
    double d = 0,
    double h = 0,
    double m = 0,
    double s = 0,
    double milli = 0,
  }) {
    double value = 0;
    value += d * 60000 * 60 * 24;
    value += h * 60000 * 60;
    value += m * 60000;
    value += s * 1000;
    value += milli;
    _milliseconds = value;
  }

  Duration.fromHours(double h) : _milliseconds = h * 60000 * 60;
  Duration.fromMinutes(double m) : _milliseconds = m * 60000;
  Duration.fromSeconds(double s) : _milliseconds = s * 1000;
  Duration.fromMilli(double m) : _milliseconds = m;

  // Display the duration in a readable format
  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    String secondsStr = seconds == 1 ? "second" : "seconds";
    String minutesStr = minutes == 1 ? "minute" : "minutes";
    String hoursStr = hours == 1 ? "hour" : "hours";
    return 'Duration($hours $hoursStr, $minutes $minutesStr, $seconds $secondsStr)';
  }

  Duration operator +(Duration other) => Duration.fromMilli(this._milliseconds + other._milliseconds);

  Duration operator -(Duration other) {
    double value = this._milliseconds - other._milliseconds;
    if (value < 0) throw Error;
    return Duration.fromMilli(value);
  }

  @override
  bool operator ==(covariant Duration other) => this._milliseconds == other._milliseconds;

  bool operator >(Duration other) => this._milliseconds > other._milliseconds;

  bool operator >=(Duration other) => this._milliseconds >= other._milliseconds;

  bool operator <(Duration other) => this._milliseconds < other._milliseconds;

  bool operator <=(Duration other) => this._milliseconds <= other._milliseconds;

  double get seconds => _milliseconds / 1000;
  double get minutes => this.seconds / 60;
  double get hours => this.minutes / 60;
}

void main() {
  Duration duration1 = Duration.fromHours(3); // 3 hours
  Duration duration2 = Duration.fromMinutes(45); // 45 minutes
  Duration duration3 = Duration(h: 1, m: 30); // one and a half hour
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1 > duration2); //true

  print(duration3); // 1 hour, 30 minutes, 0 seconds

  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e);
  }
}

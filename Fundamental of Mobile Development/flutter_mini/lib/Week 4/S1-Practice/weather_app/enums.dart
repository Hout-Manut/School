enum Cities {
  phnomPenh(11.5564, 104.9282, "Asia/Phnom_Penh", "PHNOM PENH"),
  siemReap(13.3671, 103.8448, "Asia/Phnom_Penh", "SIEM REAP"),
  paris(48.8566, 2.3522, "Europe/Paris", "PARIS"),
  newYork(40.7128, -74.0060, "America/New_York", "NEW YORK"),
  losAngeles(34.0522, -118.2437, "America/Los_Angeles", "LOS ANGELES"),
  sydney(-33.8688, 151.2093, "Australia/Sydney", "SYDNEY");

  final double latitude;
  final double longitude;
  final String timezone;
  final String displayName;

  String get latLon => "$latitude,$longitude";

  const Cities(this.latitude, this.longitude, this.timezone, this.displayName);
}

enum SelectedDay {
  beforeYesterday(0),
  yesterday(1),
  today(2),
  tomorrow(3),
  thirdDay(4),
  fourthDay(5),
  fifthDay(6);

  const SelectedDay(this.i);

  final int i;

  SelectedDay next() {
    switch (this) {
      case SelectedDay.beforeYesterday:
        return SelectedDay.yesterday;
      case SelectedDay.yesterday:
        return SelectedDay.today;
      case SelectedDay.today:
        return SelectedDay.tomorrow;
      case SelectedDay.tomorrow:
        return SelectedDay.thirdDay;
      case SelectedDay.thirdDay:
        return SelectedDay.fourthDay;
      case SelectedDay.fourthDay:
        return SelectedDay.fifthDay;
      case SelectedDay.fifthDay:
        return SelectedDay.fifthDay;
    }
  }

  SelectedDay previous() {
    switch (this) {
      case SelectedDay.beforeYesterday:
        return SelectedDay.beforeYesterday;
      case SelectedDay.yesterday:
        return SelectedDay.beforeYesterday;
      case SelectedDay.today:
        return SelectedDay.yesterday;
      case SelectedDay.tomorrow:
        return SelectedDay.today;
      case SelectedDay.thirdDay:
        return SelectedDay.tomorrow;
      case SelectedDay.fourthDay:
        return SelectedDay.thirdDay;
      case SelectedDay.fifthDay:
        return SelectedDay.fourthDay;
    }
  }
}

enum WindDirection {
  n, // North
  ne, // North-East
  e, // East
  se, // South-East
  s, // South
  sw, // South-West
  w, // West
  nw // North-West
}

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
  beforeYesterday(0, "2 Days Ago"),
  yesterday(1, "Yesterday"),
  today(2, "Today"),
  tomorrow(3, "Tomorrow"),
  thirdDay(4, "The Day After Tomorrow"),
  fourthDay(5, "The Day After The Day After Tomorrow"),
  fifthDay(6, "The Day After The Day After The Day After Tomorrow");

  const SelectedDay(this.i, this.placeholderName);

  final int i;
  final String placeholderName;

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

enum WeatherCondition {
  cloudy("Cloudy", "assets/images/weather/Cloudy.png"),
  drizzle("Drizzle", "assets/images/weather/Drizzle.png"),
  overcast("Overcast", "assets/images/weather/Overcast.png"),
  partlyCloudy("Partly CLoudy", "assets/images/weather/Partly Cloudy.png"),
  rainy("Rainy", "assets/images/weather/Rainy.png"),
  sunny("Sunny", "assets/images/weather/Sunny.png"),
  windy("Windy", "assets/images/weather/Windy.png");

  const WeatherCondition(this.displayName, this.imagePath);

  final String displayName;
  final String imagePath;
}

enum WindDirection {
  n("North"),
  ne("North East"),
  e("East"),
  se("South East"),
  s("South"),
  sw("South West"),
  w("West"),
  nw("North West");

  final String displayString;

  const WindDirection(this.displayString);
}

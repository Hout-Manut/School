enum Cities {
  phnomPenh(11.5564, 104.9282, "Asia/Phnom_Penh"),
  siemReap(13.3671, 103.8448, "Asia/Phnom_Penh"),
  paris(48.8566, 2.3522, "Europe/Paris"),
  newYork(40.7128, -74.0060, "America/New_York"),
  losAngeles(34.0522, -118.2437, "America/Los_Angeles"),
  sydney(-33.8688, 151.2093, "Australia/Sydney");

  final double latitude;
  final double longitude;
  final String timezone;

  String get latlon => "$latitude, $longitude";

  const Cities(this.latitude, this.longitude, this.timezone);
}

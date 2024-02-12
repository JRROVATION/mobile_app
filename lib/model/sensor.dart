class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;
}

class SensorData {
  double speed = 0.0;
  Location location = Location(latitude: 0.0, longitude: 0.0);
}

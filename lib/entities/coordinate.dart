class Coordinate {
  double latitude;
  double longitude;

  Coordinate(this.latitude, this.longitude);

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
        json['latitude'],
        json['longitude']
    );
  }

  Map<String, dynamic> toJson() => {
    'latitude': this.latitude,
    'longitude': this.longitude
  };
}
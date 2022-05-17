import 'package:intl/intl.dart';

import '../utils/static_const_values.dart';
import 'coordinate.dart';

class Trip {
  String id;
  DateTime startTime;
  DateTime endTime;
  Coordinate startCoordinate;
  Coordinate endCoordinate;

  Trip(this.id, this.startTime, this.endTime, this.startCoordinate,
      this.endCoordinate);

  factory Trip.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = new DateFormat(DATE_TIME_FORMAT);
    return Trip(
        json['id'],
        dateFormat.parse(json['startTime'], true),
        dateFormat.parse(json['endTime'], true) ,
        Coordinate.fromJson(json['startCoordinate']),
        Coordinate.fromJson(json['endCoordinate'])
    );
  }
}
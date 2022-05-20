import 'package:intl/intl.dart';

import '../utils/static_const_values.dart';
import 'coordinate.dart';

class Trip {
  String id;
  DateTime startTime;
  DateTime endTime;
  late Duration duration;
  Coordinate? startCoordinate;
  Coordinate? endCoordinate;

  Trip(this.id, this.startTime, this.endTime, this.startCoordinate,
      this.endCoordinate) {
    this.duration = this.endTime.difference(this.startTime);
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = new DateFormat(DATE_TIME_FORMAT);
    return Trip(
        json['id'],
        dateFormat.parse(json['startTime'], true),
        dateFormat.parse(json['endTime'], true) ,
        json['startCoordinate'] != null ? Coordinate.fromJson(json['startCoordinate']) : null,
        json['endCoordinate'] != null ? Coordinate.fromJson(json['endCoordinate']) : null
    );
  }

  static String convertDateTime(DateTime dateTime, String dateTimeFormat) {
    DateFormat dateFormat = new DateFormat(dateTimeFormat);
    return dateFormat.format(dateTime);
  }
}
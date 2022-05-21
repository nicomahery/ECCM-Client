import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../utils/static_const_values.dart';
import 'carlog.dart';

class Trip {
  String id;
  DateTime startTime;
  DateTime endTime;
  late Duration duration;
  LatLng? startCoordinate;
  LatLng? endCoordinate;
  List<CarLog>? carLogs;

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
        json['startCoordinate'] != null ? LatLng(json['startCoordinate']['latitude'], json['startCoordinate']['longitude']) : null,
        json['endCoordinate'] != null ? LatLng(json['endCoordinate']['latitude'], json['endCoordinate']['longitude']) : null
    );
  }

  static String convertDateTime(DateTime dateTime, String dateTimeFormat) {
    DateFormat dateFormat = new DateFormat(dateTimeFormat);
    return dateFormat.format(dateTime);
  }

  String getDurationString() {
    String ret = '';
    if (this.duration.inHours > 0) {
      ret += '${this.duration.inHours}h ';
    }
    if (this.duration.inMinutes > 0) {
      ret += '${this.duration.inMinutes}min';
    }
    if (this.duration.inSeconds > 0 && ret == '') {
      ret += '${this.duration.inSeconds}s';
    }
    return ret;
  }
}
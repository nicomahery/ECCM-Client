
import 'package:latlong2/latlong.dart';

import '../entities/carlog.dart';
import '../entities/trip.dart';
import '../utils/get_it_instance.dart';
import 'api_service.dart';

class TripService {
  List<Trip>? trips;
  final ApiService _apiService = locator<ApiService>();

  Future<List<Trip>?> getAllTrips() async {
    this.trips = await this._apiService.getAllTrips();
    return this.trips;
  }

  Trip? getTripForId(String id) {
    return this.trips?.firstWhere((trip) => trip.id == id, orElse: null);
  }

  Future<List<CarLog>?> getCarLogsForId(String id) async {
    Trip? trip = this.getTripForId(id);
    if (trip == null) {
      return null;
    }
    if (trip.carLogs == null) {
      trip.carLogs = await this._apiService.getAllCarLogsByTripId(id);
    }

    return trip.carLogs;
  }

  Future<num?> getDistanceForId(String id) async {
    Trip? trip = this.getTripForId(id);
    if (trip == null) {
      return null;
    }
    if (trip.distance == null) {
      List<CarLog>? carLogs = await this.getCarLogsForId(id);
      if (carLogs == null) {
        return null;
      }
      List<CarLog> gpsCarLogs = carLogs.where((element) => element.gpsLongitude != null && element.gpsLatitude != null).toList();
      gpsCarLogs.sort((a, b) => a.deviceTime.compareTo(b.deviceTime));
      num d = 0;
      final Distance distance = new Distance();
      for (int i = 1; i < gpsCarLogs.length; i++) {
        d += distance(LatLng(gpsCarLogs[i-1].gpsLatitude!, gpsCarLogs[i-1].gpsLongitude!), LatLng(gpsCarLogs[i].gpsLatitude!, gpsCarLogs[i].gpsLongitude!));
      }
      trip.distance = d;
    }

    return trip.distance;
  }
}
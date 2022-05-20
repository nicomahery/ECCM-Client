
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
    return this.trips?.firstWhere((trip) => trip.id == id);
  }
}
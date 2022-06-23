
import 'dart:convert';

import 'package:eccm_client/entities/carlog.dart';
import 'package:eccm_client/services/config_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:http/http.dart' as http;
import '../entities/trip.dart';

const String TRIPS_CONTROLLER_PATH = 'api/trips/';
const String PAGINATION_PATH = 'pageable';
const String TRIP_IDS_PATH = '${TRIPS_CONTROLLER_PATH}ids';
const String CAR_LOG_CONTROLLER_PATH = 'api/carlogs/';
const String CAR_LOG_BY_TRIP_ID_PATH = '${CAR_LOG_CONTROLLER_PATH}findByTripId/';
const String PING_PATH = 'api/ping';
const String PING_GOOD_RESPONSE = 'pong';

class ApiService {
  late ConfigService _configService;

  ApiService() {
    this._configService = locator<ConfigService>();
  }

  bool isApiConfig() {
    return (this._configService.apiLocation != null
        && this._configService.apiSecretHeader != null
        && this._configService.apiSecret != null
    );
  }

  Future<List<Trip>?> getAllTrips() async {
    if (!this.isApiConfig()) {
      return null;
    }
    var client = http.Client();
    var returnValue = null;
    try {
      var response = await client.get(
          Uri.https(this._configService.apiLocation!, '$TRIPS_CONTROLLER_PATH'),
          headers: {
            'Content-Type': 'application/json',
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          }
      );
      if (response.statusCode == 200) {
        returnValue = (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((trip) => Trip.fromJson(trip)).toList();
      }
    } catch (e) {
      print(e);
    }
    finally {
      client.close();
      return returnValue;
    }
  }

  Future<List<Trip>?> getAllTripsPagination(int pageNumber, int pageSize) async {
    if (!this.isApiConfig()) {
      return null;
    }
    var client = http.Client();
    var returnValue = null;
    try {
      var response = await client.get(
          Uri.https(this._configService.apiLocation!,
              '${TRIPS_CONTROLLER_PATH}${PAGINATION_PATH}',
              {'page':pageNumber.toString(),
                'size':pageSize.toString(),
                'sort':'startTime,desc'}),
          headers: {
            'Content-Type': 'application/json',
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          },

      );
      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(utf8.decode(response.bodyBytes));
        returnValue = (parsedJson['content'] as List).map((trip) => Trip.fromJson(trip)).toList();
      }
    } catch (e) {
      print(e);
    }
    finally {
      client.close();
      return returnValue;
    }
  }

  Future<List<CarLog>?> getAllCarLogsByTripId(String tripId) async {
    if (!this.isApiConfig()) {
      return null;
    }
    var client = http.Client();
    var returnValue = null;
    try {
      var response = await client.get(
          Uri.https(this._configService.apiLocation!, '$CAR_LOG_BY_TRIP_ID_PATH$tripId'),
          headers: {
            'Content-Type': 'application/json',
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          }
      );
      if (response.statusCode == 200) {
        returnValue = (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((carLog) => CarLog.fromJson(carLog)).toList();
      }
    } catch (e) {
      print(e);
    }
    finally {
      client.close();
      return returnValue;
    }
  }

  Future<List<String>?> getAllTripIds() async {
    if (!this.isApiConfig()) {
      return null;
    }
    var client = http.Client();
    var returnValue = null;
    try {
      var response = await client.get(
        Uri.https(this._configService.apiLocation!, TRIP_IDS_PATH),
        headers: {
          'Content-Type': 'application/json',
          this._configService.apiSecretHeader!: this._configService.apiSecret!
        }
      );
      if (response.statusCode == 200) {
        returnValue = (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((e) => e.toString()).toList();
      }
    } catch (e) {
      print(e);
    }
    finally {
      client.close();
      return returnValue;
    }
  }

  Future<bool> ping() async {
    var client = http.Client();
    var returnValue = false;
    try {
      var response = await client.get(
          Uri.https(this._configService.apiLocation!, PING_PATH),
          headers: {
            'Content-Type': 'application/json',
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          }
      );
      if (response.statusCode == 200) {
        returnValue = response.body == PING_GOOD_RESPONSE;
      }
    } catch (e) {
      print(e);
    }
    finally {
      client.close();
      return returnValue;
    }
  }
}
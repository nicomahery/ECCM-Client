
import 'dart:convert';
import 'dart:io';

import 'package:eccm_client/entities/carlog.dart';
import 'package:eccm_client/services/config_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:http/http.dart' as http;
import '../entities/trip.dart';
import 'package:dio/dio.dart';

const String TRIPS_CONTROLLER_PATH = 'api/trips/';
const String TRIP_IDS_PATH = '${TRIPS_CONTROLLER_PATH}ids';
const String CAR_LOG_CONTROLLER_PATH = 'api/carlogs/';
const String CAR_LOG_BY_TRIP_ID_PATH = '${CAR_LOG_CONTROLLER_PATH}/findByTripId/';
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
    if (this.isApiConfig()) {
      return null;
    }
    try {
      var response = await Dio().get(
          '${this._configService.apiLocation}$TRIPS_CONTROLLER_PATH',
          options: Options(headers: {
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          })
      );
      if (response.statusCode != 200) {
        return null;
      }
      return (response.data as List).map((trip) => Trip.fromJson(trip)).toList();
    } catch (e) {
      print(e);
    }
    finally {
      return null;
    }
  }

  Future<List<CarLog>?> getAllCarLogsByTripId(String tripId) async {
    if (this.isApiConfig()) {
      return null;
    }
    try {
      var response = await Dio().get(
          '${this._configService.apiLocation}$CAR_LOG_BY_TRIP_ID_PATH$tripId',
          options: Options(headers: {
            this._configService.apiSecretHeader!: this._configService.apiSecret!
          })
      );
      if (response.statusCode != 200) {
        return null;
      }
      return (response.data as List).map((carLog) => CarLog.fromJson(carLog)).toList();
    } catch (e) {
      print(e);
    }
    finally {
      return null;
    }
  }

  Future<List<String>?> getAllTripIds() async {
    if (this.isApiConfig()) {
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
      if (response.statusCode != 200) {
        returnValue = null;
      }
      else {
        print(jsonDecode(utf8.decode(response.bodyBytes)) as List<String>);
        returnValue = jsonDecode(utf8.decode(response.bodyBytes)) as List<String>;
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
      if (response.statusCode != 200) {
        returnValue = false;
      }
      else {
        returnValue = response.body == PING_GOOD_RESPONSE;
      }
    } catch (e) {
      print(e);
      print('EEEEEEEEEE');
    }
    finally {
      client.close();
      return returnValue;
    }
  }
}
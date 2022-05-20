import 'package:eccm_client/entities/carlog.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../entities/trip.dart';
import '../services/trip_service.dart';

class TripPage extends StatefulWidget {
  static const String PATH = '/trip';
  late final Trip? trip;
  final TripService tripService = locator<TripService>();
  final ApiService _apiService = locator<ApiService>();

  TripPage({required String? tripId}) {
    if (tripId != null) {
      this.trip = this.tripService.getTripForId(tripId);
    }
  }

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Trip'),
        ),
        body: () {
          if (this.widget.trip == null) {
            return Container(
              child: Text('NO TRIP'),
            );
          }

          return FutureBuilder(
            builder: (context, AsyncSnapshot<List<CarLog>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                print(snapshot.error);
                return Icon(Icons.error, color: Colors.red);
              }
              if (snapshot.connectionState == ConnectionState.none || snapshot.data == null) {
                return Text('No Car Logs');
              }

              List<CarLog> carLogs = snapshot.data!;
              carLogs.sort((a, b) => a.deviceTime.compareTo(b.deviceTime));
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    () {
                      if (!this._isCarLogWithGPSData(carLogs)) {
                        return Container();
                      }

                      return Container(
                        height: height * 0.5,
                        width: width,
                        child: FlutterMap(
                          options: MapOptions(
                            bounds: LatLngBounds(this._getFirstCoordinate(carLogs), this._getLastCoordinate(carLogs)),
                            boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                            zoom: 13.0,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                              attributionBuilder: (_) {
                                return Text("© OpenStreetMap contributors");
                              },
                            ),
                            PolylineLayerOptions(
                              polylines: [
                                Polyline(
                                  points: this._filterWithGPSData(carLogs).map((e)
                                  => LatLng(e.gpsLatitude!, e.gpsLongitude!)).toList(),
                                  color: Colors.red,
                                  strokeWidth: 3
                                )
                              ]
                            )
                          ],
                        ),
                      );
                    } ()
                  ],
              );
            },
            future: this.widget._apiService.getAllCarLogsByTripId(this.widget.trip!.id),
          );
        } ()
    );

  }

  LatLng _getFirstCoordinate(List<CarLog> carLogs) {
    CarLog carLog = carLogs.firstWhere((element) => element.gpsLatitude != null && element.gpsLongitude != null);
    return LatLng(carLog.gpsLatitude!, carLog.gpsLongitude!);
  }

  LatLng _getLastCoordinate(List<CarLog> carLogs) {
    CarLog carLog = carLogs.lastWhere((element) => element.gpsLatitude != null && element.gpsLongitude != null);
    return LatLng(carLog.gpsLatitude!, carLog.gpsLongitude!);
  }

  bool _isCarLogWithGPSData(List<CarLog> carLogs) {
    return carLogs.any((element) => element.gpsLatitude != null && element.gpsLongitude != null);
  }

  List<CarLog> _filterWithGPSData(List<CarLog> carLogs) {
    List<CarLog> carLogsFiltered = carLogs.where((element) => element.gpsLatitude != null && element.gpsLongitude != null).toList();
    carLogsFiltered.sort((a, b) => a.deviceTime.compareTo(b.deviceTime));
    return carLogsFiltered;
  }
}

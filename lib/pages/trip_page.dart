import 'package:eccm_client/entities/carlog.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:eccm_client/utils/static_const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../entities/trip.dart';
import '../services/trip_service.dart';

class TripPage extends StatefulWidget {
  static const String PATH = '/trip';
  late final Trip? trip;
  final TripService _tripService = locator<TripService>();
  final ApiService _apiService = locator<ApiService>();

  TripPage({required String? tripId}) {
    if (tripId != null) {
      this.trip = this._tripService.getTripForId(tripId);
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
          title: const Text('Trip summary'),
        ),
        body: () {
          if (this.widget.trip == null) {
            return Container(
              child: Text('NO TRIP'),
            );
          }

          return FutureBuilder(
            future: this.widget._tripService.getCarLogsForId(this.widget.trip!.id),
            builder: (context, AsyncSnapshot<List<CarLog>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Icon(Icons.error, color: Colors.red));
              }
              if (snapshot.connectionState == ConnectionState.none || snapshot.data == null) {
                return Center(child: Text('No Car Logs'));
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
                        height: height * 0.20,
                        width: width,
                        child: FlutterMap(
                          options: MapOptions(
                            bounds: LatLngBounds(this._getFirstCoordinate(carLogs), this._getLastCoordinate(carLogs)),
                            boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                            zoom: 5,
                            interactiveFlags: InteractiveFlag.none
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                              attributionBuilder: (_) {
                                return Text(
                                  "© OpenStreetMap contributors",
                                  style: TextStyle(
                                      fontSize: width * 0.025
                                  ),
                                );
                              },
                            ),
                            PolylineLayerOptions(
                              polylines: [
                                Polyline(
                                  points: this._filterWithGPSData(carLogs).map((e)
                                  => LatLng(e.gpsLatitude!, e.gpsLongitude!)).toList(),
                                  color: Colors.indigo,
                                  strokeWidth: 5
                                ),
                              ]
                            ),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                    point: this._getFirstCoordinate(carLogs),
                                    builder: (context) => Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    )
                                ),
                                Marker(
                                    point: this._getLastCoordinate(carLogs),
                                    builder: (context) => Icon(
                                      Icons.location_on,
                                      color: Colors.blueAccent,
                                    )
                                )
                              ]
                            )
                          ],
                        ),
                      );
                    } (),
                    Container(
                      padding: EdgeInsets.only(top: height * 0.015),
                      child: Row(
                        children: [
                          Spacer(flex: 1),
                          Container(
                            width: width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Text(
                                        Trip.convertDateTime(this.widget.trip!.startTime, DATE_TIME_DISPLAY_FORMAT),
                                        style: TextStyle(
                                          fontSize: width * 0.04
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_sharp,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Text(
                                        this.widget.trip!.getDurationString(),
                                        style: TextStyle(
                                          fontSize: width * 0.04
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blueAccent,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Text(
                                        Trip.convertDateTime(this.widget.trip!.endTime, DATE_TIME_DISPLAY_FORMAT),
                                        style: TextStyle(
                                          fontSize: width * 0.04
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Trip.convertDateTime(this.widget.trip!.startTime, DATE_TIME_DISPLAY_FORMAT),
                                style: TextStyle(
                                    fontSize: width * 0.04
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ],
              );
            },
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

import 'package:eccm_client/entities/carlog.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:eccm_client/utils/static_const_values.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../entities/trip.dart';
import '../services/trip_service.dart';
import '../utils/metric.dart';

class TripPage extends StatefulWidget {
  static const String PATH = '/trip';
  late final Trip? trip;
  final TripService _tripService = locator<TripService>();

  TripPage({required String? tripId}) {
    if (tripId != null) {
      this.trip = this._tripService.getTripForId(tripId);
    }
  }

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String chartKey = CarLog.SPEED_KEY;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double iconSize = width < height ? width * 0.04 : height * 0.03;
    double textSize = width < height ? width * 0.04 : height * 0.03;
    return Scaffold(
        backgroundColor: Colors.black,
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
            future: this.widget._tripService.getCarLogsForTripId(this.widget.trip!.id),
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
                            bounds: this._getBounds(carLogs),
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
                                      fontSize: textSize * 0.8
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
                                      color: Colors.blueAccent,
                                    )
                                ),
                                Marker(
                                    point: this._getLastCoordinate(carLogs),
                                    builder: (context) => Icon(
                                      Icons.location_on,
                                      color: Colors.red,
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
                                      color: Colors.blueAccent,
                                      size: iconSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Text(
                                        Trip.convertDateTime(this.widget.trip!.startTime, DATE_TIME_DISPLAY_FORMAT),
                                        style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: iconSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width * 0.02),
                                      child: Text(
                                        Trip.convertDateTime(this.widget.trip!.endTime, DATE_TIME_DISPLAY_FORMAT),
                                        style: TextStyle(
                                          fontSize: textSize,
                                          color: Colors.white
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
                              FutureBuilder(
                                builder: (context, AsyncSnapshot<num?> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                                    print(snapshot.error);
                                    return Center(child: Icon(Icons.error, color: Colors.red));
                                  }
                                  if (snapshot.connectionState == ConnectionState.none || snapshot.data == null) {
                                    return Container();
                                  }

                                  return Row(
                                    children: [
                                      Text(
                                            (){
                                          if (snapshot.data! >= 1000) {
                                            return '${(snapshot.data!/1000).toStringAsFixed(1)}km';
                                          }
                                          return '${snapshot.data!.toStringAsFixed(0)}m';
                                        }(),
                                        style: TextStyle(
                                            fontSize: textSize,
                                            color: Colors.white
                                        ),
                                      ),
                                      Icon(
                                        Icons.route,
                                        size: iconSize,
                                        color: Colors.white
                                      )
                                    ],
                                  );
                                },
                                future: this.widget._tripService.getDistanceForId(this.widget.trip!.id),
                              ),
                              Row(
                                children: [
                                  Text(
                                    this.widget.trip!.getDurationString(),
                                    style: TextStyle(
                                        fontSize: textSize,
                                        color: Colors.white
                                    ),
                                  ),
                                  Icon(
                                    Icons.access_alarm,
                                    size: iconSize,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                        ],
                      ),
                    ),
                    DropdownButton<String>(
                      items: [
                        DropdownMenuItem(
                          child: Text('SPEED'),
                          value: CarLog.SPEED_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('RPM'),
                          value: CarLog.RPM_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('ENG. LOAD'),
                          value: CarLog.ENGINE_LOAD_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('COOLANT T'),
                          value: CarLog.COOLANT_TEMP_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('INTAKE T'),
                          value: CarLog.INTAKE_TEMP_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('INTAKE P'),
                          value: CarLog.INTAKE_PRESSURE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('BARO. P'),
                          value: CarLog.BAROMETRIC_PRESSURE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('TIMING ADVANCE'),
                          value: CarLog.TIMING_ADVANCE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('EVAP. PURGE'),
                          value: CarLog.EVAPORATIVE_PURGE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('CONT. MODULE V'),
                          value: CarLog.CONTROL_MODULE_VOLTAGE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('LONG FUEL TRIM1'),
                          value: CarLog.LONG_FUEL_TRIM_1_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('LONG FUEL TRIM2'),
                          value: CarLog.LONG_FUEL_TRIM_2_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('SHORT FUEL TRIM1'),
                          value: CarLog.SHORT_FUEL_TRIM_1_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('SHORT FUEL TRIM2'),
                          value: CarLog.SHORT_FUEL_TRIM_2_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('CATALYST T B1 S1'),
                          value: CarLog.CATALYST_TEMP_B1_S1_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('CATALYST T B1 S2'),
                          value: CarLog.CATALYST_TEMP_B1_S2_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('CATALYST T B2 S1'),
                          value: CarLog.CATALYST_TEMP_B2_S1_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('CATALYST T B2 S2'),
                          value: CarLog.CATALYST_TEMP_B2_S2_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('FUEL RAIL P ABS'),
                          value: CarLog.FUEL_RAIL_PRESSURE_ABS_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('EGR ERROR'),
                          value: CarLog.EGR_ERROR_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('REL. ACCEL POS'),
                          value: CarLog.RELATIVE_ACCEL_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('REL. THROT POS'),
                          value: CarLog.RELATIVE_THROTTLE_POS_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('MAF'),
                          value: CarLog.MAF_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('MAX MAF'),
                          value: CarLog.MAX_MAF_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('AIR FLOW R'),
                          value: CarLog.AIR_FLOW_RATE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('OIL T'),
                          value: CarLog.OIL_TEMP_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('FUEL RATE'),
                          value: CarLog.FUEL_RATE_KEY,
                        ),
                        DropdownMenuItem(
                          child: Text('AMB. AIR T'),
                          value: CarLog.AMBIANT_AIR_TEMP_KEY,
                        ),
                      ],
                      onChanged: (String? value) {
                        if (this.mounted && value != null) {
                          setState(() {
                            this.chartKey = value;
                          });
                        }
                      },
                      value: this.chartKey,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      dropdownColor: Colors.black,
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    FutureBuilder(
                        future: this.widget._tripService.getMetricByTripId(this.chartKey, this.widget.trip!.id),
                        builder: (context,
                            AsyncSnapshot<Metric?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done && snapshot.hasError) {
                            print(snapshot.error);
                            return Center(child: Icon(
                                Icons.error, color: Colors.red));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none || snapshot.data == null) {
                            return Center(child: Text('no data', style: TextStyle(color: Colors.white)));
                          }

                          Metric metric = snapshot.data!;
                          if (metric.dateTimeDataMap.isEmpty) {
                            return Center(child: Text('no data', style: TextStyle(color: Colors.white)));
                          }

                          double intervalX = (metric.indexDataMap.length) /  (this.widget.trip!.duration.inMinutes < 1 ? 1 : 3);
                          double intervalY = (metric.maxValue - metric.minValue) / ((metric.maxValue - metric.minValue) < 4? 3 : 4);
                          return Container(
                            width: width * 0.9,
                            height: height * 0.3,
                            child: LineChart(
                                LineChartData(
                                  minY: metric.minValue.toDouble(),
                                  maxY: metric.maxValue.toDouble(),
                                  minX: 1,
                                  maxX: metric.indexDataMap.length.toDouble(),
                                  borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(color: Colors.white, width: 1)),
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: true,
                                    horizontalInterval: intervalY,
                                    verticalInterval: intervalX,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return FlLine(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: intervalY,
                                        getTitlesWidget:  (double value, TitleMeta meta) {
                                          return Text(
                                              value.toInt().toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.left
                                          );
                                        },
                                        reservedSize: 42,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        interval: intervalX,
                                        getTitlesWidget: (double value, TitleMeta meta) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                new DateFormat(intervalX == 1 ? HOUR_WITH_SECONDS_DISPLAY_FORMAT : HOUR_DISPLAY_FORMAT).format(metric.dateTimeDataMap.keys.toList()[value.toInt() - 1]),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.left
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: metric.indexDataMap.entries.map((e) => FlSpot(e.key.toDouble(), e.value.toDouble())).toList(),
                                      dotData: FlDotData(
                                        show: false,
                                      ),

                                    )
                                  ],
                                )
                            ),
                          );
                        }
                    ),
                  ],
              );
            },
          );
        } ()
    );

  }

  LatLngBounds _getBounds(List<CarLog> carLogs) {
    List<double> longitudes = carLogs.where((element) => element.gpsLongitude != null).map((e) => e.gpsLongitude!).toList();
    longitudes.sort();
    List<double> latitudes = carLogs.where((element) => element.gpsLatitude != null).map((e) => e.gpsLatitude!).toList();
    latitudes.sort();
    return LatLngBounds(LatLng(latitudes.first, longitudes.first), LatLng(latitudes.last, longitudes.last));
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


import 'package:eccm_client/pages/trip_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../entities/trip.dart';
import '../utils/static_const_values.dart';

class TripSummaryCardWidget extends StatelessWidget {
  final Trip trip;
  static const String PATH = '/trip';

  const TripSummaryCardWidget({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: ListTile(
          leading: Icon(Icons.route),
          title: Text(Trip.convertDateTime(this.trip.startTime, DATE_TIME_DISPLAY_FORMAT)),
          subtitle: Text('${this.trip.duration.inMinutes}min'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        onTap: () {
          context.push(TripPage.PATH + '/${this.trip.id}');
        },
      ),
    );
  }
}

import 'package:eccm_client/entities/trip.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/services/api_service.dart';
import 'package:eccm_client/services/trip_service.dart';
import 'package:eccm_client/widgets/trip_summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../entities/carlog.dart';
import '../utils/get_it_instance.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String PATH = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TripService _tripService = locator<TripService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () => context.push(SettingPage.PATH),
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Trip>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
              print(snapshot.error);
              return Icon(Icons.error, color: Colors.red);
            }

            List<Trip> trips = snapshot.data!;
            trips.sort((a, b) => b.startTime.compareTo(a.startTime));
            return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return TripSummaryCardWidget(trip: snapshot.data![index]);
                }
            );
          },
          future: this._tripService.getAllTrips(),
        ),
      ),
    );
  }
}



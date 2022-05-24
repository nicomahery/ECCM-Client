import 'package:eccm_client/entities/trip.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/pages/trip_list_page.dart';
import 'package:eccm_client/services/trip_service.dart';
import 'package:eccm_client/widgets/trip_summary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/get_it_instance.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String PATH = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => context.push(TripListPage.PATH), 
                child: Text('Trips')
            )
          ],
        )
      ),
    );
  }
}



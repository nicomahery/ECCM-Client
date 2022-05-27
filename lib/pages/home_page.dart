import 'package:eccm_client/pages/live_page.dart';
import 'package:eccm_client/pages/setting_page.dart';
import 'package:eccm_client/pages/trip_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String PATH = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            Spacer(),
            Container(
              width: width * 0.7,
              height: height * 0.2,
              child: ElevatedButton(
                  onPressed: () => context.push(TripListPage.PATH),
                  child: Text('Trips')
              ),
            ),
            Spacer(),
            Container(
              width: width * 0.7,
              height: height * 0.2,
              child: ElevatedButton(
                  onPressed: () => context.push(LivePage.PATH),
                  child: Text('Live')
              ),
            ),
            Spacer(),
          ],
        )
      ),
    );
  }
}



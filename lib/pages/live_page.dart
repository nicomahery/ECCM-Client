import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class LivePage extends StatefulWidget {
  static const String PATH = '/live';
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Live Page'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('ECCM', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('OPE', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('DTC', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DashboardPage(),
            Icon(Icons.directions_car, color: Colors.white),
            Icon(Icons.directions_car, color: Colors.white)
          ],
        )
      ),
    );
  }
}


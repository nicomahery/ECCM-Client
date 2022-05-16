import 'package:eccm_widget/widgets/BigArcGaugeWidget.dart';
import 'package:eccm_widget/widgets/DemiCircularGaugeWidget.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BigArcGaugeWidget(
              width: 250,
              maxValue: 5,
              minValue: 0,
              thresholdValue: 4,
              valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
            ),
            DemiCircularGaugeWidget(
              width: 250,
              maxValue: 5,
              minValue: 0,
              thresholdValue: 4,
              valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
            ),
          ],
        ),
      ),
    );
  }
}

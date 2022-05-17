
import 'package:eccm_widget/widgets/BigArcGaugeWidget.dart';
import 'package:eccm_widget/widgets/DemiCircularGaugeWidget.dart';
import 'package:flutter/material.dart';

class WidgetTestPage extends StatefulWidget {
  const WidgetTestPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WidgetTestPage> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {

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
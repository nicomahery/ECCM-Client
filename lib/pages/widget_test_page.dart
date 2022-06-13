
import 'package:eccm_client/utils/static_const_values.dart';
import 'package:flutter/material.dart';

import '../widgets/gauge_widget.dart';

class WidgetTestPage extends StatelessWidget {
  const WidgetTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'CAT T B1 S1',
                unitText: 'UNIT',
              ),
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'WARM DTC C',
                unitText: 'UNIT',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.DEMI_CIRCULAR,
                labelText: 'BARO P',
                unitText: 'UNIT',
              ),
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.DEMI_CIRCULAR,
                labelText: 'A THROT P B',
                unitText: 'UNIT',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
              GaugeWidget(
                width: width * 0.22,
                maxValue: 5,
                minValue: 0,
                thresholdValue: 4,
                valueUpdateStream: Stream<num>.periodic(const Duration(seconds: 1), (x) => (x * 0.1) % 5),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: 'LABELS',
                unitText: 'UNIT',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
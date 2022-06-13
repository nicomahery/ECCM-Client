import 'package:eccm_client/utils/static_const_values.dart';
import 'package:eccm_widget/widgets/BigArcGaugeWidget.dart';
import 'package:eccm_widget/widgets/DemiCircularGaugeWidget.dart';
import 'package:flutter/material.dart';

class GaugeWidget extends StatelessWidget {
  const GaugeWidget({
    Key? key, required this.width, required this.gaugeType,
    required this.valueUpdateStream, required this.maxValue,
    required this.minValue, required this.thresholdValue,
    required this.labelText, required this.unitText,
    required this.labelPosition
  }) : super(key: key);
  final double width;
  final Stream<num> valueUpdateStream;
  final num maxValue;
  final num minValue;
  final num thresholdValue;
  final GaugeType gaugeType;
  final LabelPosition labelPosition;
  final String labelText;
  final String unitText;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: this.width * 2,
      height: this.width,
      child: Stack(
        children: [
          Positioned(
            left: this.labelPosition == LabelPosition.LEFT ? this.width * 0.01 : null,
            right: this.labelPosition == LabelPosition.RIGHT ? this.width * 0.01 : null,
            bottom: this.width * 0.25,
            child: this._getLabelUnitColumn(),
          ),
          Positioned(
              left: this.labelPosition == LabelPosition.RIGHT ? 0 : null,
              right: this.labelPosition == LabelPosition.LEFT ? 0 : null,
              bottom: width * 0.25,
              child: this._getGauge()
          )
        ],
      ),
    );
  }

  Widget _getGauge() {
    switch(this.gaugeType) {
      case GaugeType.DEMI_CIRCULAR:
        return DemiCircularGaugeWidget(
            width: this.width * 1.10,
            valueUpdateStream: this.valueUpdateStream,
            maxValue: this.maxValue,
            minValue: this.minValue,
            thresholdValue: this.thresholdValue
        );
      case GaugeType.BIG_ARC:
        return BigArcGaugeWidget(
            width: width,
            valueUpdateStream: valueUpdateStream,
            maxValue: maxValue,
            minValue: minValue,
            thresholdValue: thresholdValue
        );
    }
  }

  Widget _getLabelUnitColumn() {
    return Container(
      width: this.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              this.labelText,
              style: TextStyle(
                color: Colors.white,
                fontSize: this.width * 0.15,
                fontWeight: FontWeight.w500
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: this.width * 0.01),
              child: Text(
                this.unitText,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: this.width * 0.15,
                    fontWeight: FontWeight.w400
                )
              ),
            ),
          ],
        ),
    );
  }
}

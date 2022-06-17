import 'package:flutter/material.dart';

import '../services/socket_service.dart';
import '../utils/get_it_instance.dart';
import '../utils/static_const_values.dart';
import '../widgets/gauge_widget.dart';
import '../widgets/message_list_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final SocketService _socketService = locator<SocketService>();

  Stream<num> valueStream(String command) async* {
    while (true) {
      String? result = await this._socketService.queryCommand(command);
      if (result != null && result != 'None') {
        List<String> split = result.split(' ');
        if (split.length == 2) {
          num? ret = num.tryParse(split.first);
          if (ret != null) {
            yield ret;
          }
        }
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double gaugeSize = width < height ? width * 0.22 : height * 0.25;
    return ListView(
      padding: EdgeInsets.only(top: height * 0.03),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GaugeWidget(
              width: gaugeSize,
              minValue: 0,
              maxValue: 100,
              thresholdValue: 70,
              valueUpdateStream: this.valueStream('THROTTLE_POS'),
              labelPosition: LabelPosition.LEFT,
              gaugeType: GaugeType.BIG_ARC,
              labelText: COMMAND_TO_LABEL_MAP['THROTTLE_POS'],
              unitText: '%',
            ),
            GaugeWidget(
              width: gaugeSize,
              minValue: 0,
              maxValue: 8000,
              thresholdValue: 5000,
              valueUpdateStream: this.valueStream('RPM'),
              labelPosition: LabelPosition.RIGHT,
              gaugeType: GaugeType.BIG_ARC,
              labelText: COMMAND_TO_LABEL_MAP['RPM'],
              unitText: 'r/min',
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: gaugeSize,
                minValue: 0,
                maxValue: 200,
                thresholdValue: 150,
                valueUpdateStream: this.valueStream('COOLANT_TEMP'),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: COMMAND_TO_LABEL_MAP['COOLANT_TEMP'],
                unitText: '°C',
              ),
              GaugeWidget(
                width: gaugeSize,
                minValue: 0,
                maxValue: 100,
                thresholdValue: 90,
                valueUpdateStream: this.valueStream('ENGINE_LOAD'),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: COMMAND_TO_LABEL_MAP['ENGINE_LOAD'],
                unitText: '%',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GaugeWidget(
                width: gaugeSize,
                minValue: 0,
                maxValue: 80,
                thresholdValue: 50,
                valueUpdateStream: this.valueStream('INTAKE_TEMP'),
                labelPosition: LabelPosition.LEFT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: COMMAND_TO_LABEL_MAP['INTAKE_TEMP'],
                unitText: '°C',
              ),
              GaugeWidget(
                width: gaugeSize,
                minValue: 0,
                maxValue: 300,
                thresholdValue: 200,
                valueUpdateStream: this.valueStream('INTAKE_PRESSURE'),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: COMMAND_TO_LABEL_MAP['INTAKE_PRESSURE'],
                unitText: 'kPa',
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.grey,
                height: 5,
                width: width * 0.55,
              ),
              Container(
                color: Colors.grey,
                height: 5,
                width: width * 0.33,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.028),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MessageListWidget(
                height: height * 0.2,
                width: width * 0.57,
                stream: this._socketService.subscribeToStatusUpdates(),
              ),
              Container(
                color: Colors.grey,
                height: height * 0.2,
                width: 5,
              ),
              Container(
                height: height * 0.2,
                width: width * 0.35,
                child: ListView(
                  children: [
                    Container(
                      height: (height * 0.2) * 0.4,
                      child: OutlinedButton(
                          onPressed: () => this._socketService.syncFile(false),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
                            side: MaterialStateProperty.all(BorderSide(
                                color: Colors.grey.shade400,
                                width: height > width ? width * 0.008
                                    : height * 0.009)
                            ),
                          ),
                          child: Text(
                            'SYNC STOP',
                            style: TextStyle(
                                fontSize: width > height ? width * 0.025 : height * 0.03,
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                            ),
                            textAlign: TextAlign.center
                          )
                      ),
                    ),
                    Container(
                      height: (height * 0.2) * 0.1,
                    ),
                    Container(
                      height: (height * 0.2) * 0.4,
                      child: OutlinedButton(
                          onPressed: () => this._socketService.syncFile(true),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
                            side: MaterialStateProperty.all(
                                BorderSide(
                                    color: Colors.grey.shade400,
                                    width: height > width ? width * 0.008
                                        : height * 0.009)
                            ),
                          ),
                          child: Text(
                            'SYNC RESTART',
                            style: TextStyle(
                              fontSize: width > height ? width * 0.025 : height * 0.03,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,

                            ),
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

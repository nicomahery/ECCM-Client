import 'package:flutter/material.dart';

import '../services/socket_service.dart';
import '../utils/get_it_instance.dart';
import '../utils/static_const_values.dart';
import '../widgets/gauge_widget.dart';

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
                thresholdValue: 300,
                valueUpdateStream: this.valueStream('INTAKE_PRESSURE'),
                labelPosition: LabelPosition.RIGHT,
                gaugeType: GaugeType.BIG_ARC,
                labelText: COMMAND_TO_LABEL_MAP['INTAKE_PRESSURE'],
                unitText: 'r/min',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*Widget test() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<String?>(
              stream: this.valueStream('SPEED'),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Text('XX km/h', style: TextStyle(color: Colors.white));
                  }
                  else {
                    return Text('${snapshot.data!} km/h', style: TextStyle(color: Colors.white));
                  }

                } else if (snapshot.hasError) {
                  return Icon(Icons.error, color: Colors.red,);
                }
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              },
            ),
            StreamBuilder<String?>(
              stream: this.valueStream('RPM'),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Text('XX rpm', style: TextStyle(color: Colors.white));
                  }
                  else {
                    return Text('${snapshot.data!} rpm', style: TextStyle(color: Colors.white));
                  }

                } else if (snapshot.hasError) {
                  return Icon(Icons.error, color: Colors.red,);
                }
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              },
            ),
            StreamBuilder<String?>(
              stream: this.valueStream('COOLANT_TEMP'),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Text('XX C°', style: TextStyle(color: Colors.white),);
                  }
                  else {
                    return Text('${snapshot.data!} C°', style: TextStyle(color: Colors.white));
                  }

                } else if (snapshot.hasError) {
                  return Icon(Icons.error, color: Colors.red,);
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        )
    );
  }*/
}

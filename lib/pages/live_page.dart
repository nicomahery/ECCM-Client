import 'dart:async';

import 'package:eccm_client/services/socket_service.dart';
import 'package:flutter/material.dart';

import '../utils/get_it_instance.dart';

class LivePage extends StatefulWidget {
  static const String PATH = '/live';
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  Timer? _timer;
  SocketService _socketService = locator<SocketService>();
  String speed = '';
  bool _streamRunning = true;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    this._timer?.cancel();
    super.dispose();
  }

  Stream<String?> valueStream(String command) async* {
    while (this._streamRunning) {
      yield await this._socketService.queryCommand(command);
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Live Page'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<String?>(
                stream: this.valueStream('SPEED'),
                builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Text('XX km/h');
                    }
                    else {
                      return Text('${snapshot.data!} km/h');
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
                      return Text('XX rpm');
                    }
                    else {
                      return Text('${snapshot.data!} rpm');
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
                      return Text('XX C°');
                    }
                    else {
                      return Text('${snapshot.data!} C°');
                    }

                  } else if (snapshot.hasError) {
                    return Icon(Icons.error, color: Colors.red,);
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          )
      ),
    );
  }
}


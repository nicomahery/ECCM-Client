import 'package:eccm_client/pages/widget_test_page.dart';
import 'package:eccm_client/utils/get_it_instance.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTestPage(title: 'Flutter Demo Home Page'),
    );
  }
}


import 'package:flutter/material.dart';

import '../entities/status_list.dart';

class MessageListWidget extends StatefulWidget {
  const MessageListWidget({Key? key, required this.width, required this.height,
    required this.stream}) : super(key: key);
  final double width;
  final double height;
  final Stream<StatusList?>? stream;

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double messageSize = MediaQuery.of(context).size.width * 0.035;
    return Container(
      width: this.widget.width,
      height: this.widget.height,
      child: StreamBuilder(
        initialData: null,
        stream: this.widget.stream,
        builder: (BuildContext context, AsyncSnapshot<StatusList?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Text> texts = [];
            for (String error in snapshot.data!.errors) {
              texts.add(Text(error, style: TextStyle(
                  fontSize: messageSize, color: Colors.red)));
            }
            for (String warning in snapshot.data!.warnings) {
              texts.add(Text(warning, style: TextStyle(
                  fontSize: messageSize, color: Colors.orange)));
            }
            for (String info in snapshot.data!.info) {
              texts.add(Text(info, style: TextStyle(
                  fontSize: messageSize, color: Colors.lightBlueAccent)));
            }
            if (texts.isNotEmpty) {
              return ListView(
                children: texts,
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

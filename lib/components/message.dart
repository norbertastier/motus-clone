import 'package:flutter/cupertino.dart';

class Message extends StatelessWidget{

  final bool show;
  final String message;

  const Message({
    required bool this.show,
    required String this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: show
            ? Center(
          child: Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        )
            : Container());
  }
}



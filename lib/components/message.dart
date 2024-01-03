import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';

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
        //color: Colors.red,
        height: 60,
        child: show
            ? Center(
          child: Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: background,
              )),
        )
            : Container());
  }
}




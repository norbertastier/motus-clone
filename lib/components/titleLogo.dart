import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 40;
    final Color redColor = Color(0xffdb3a34);
    final Color orangeColor = Color(0xfff7b735);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildColoredBox('M', height, redColor),
        _buildTransparentBox('O', height),
        _buildColoredBox('T', height, orangeColor, circular: true),
        _buildTransparentBox('U', height),
        _buildColoredBox('S', height, redColor),
      ],
    );
  }

  Widget _buildColoredBox(String text, double height, Color color, {bool circular = false}) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular ? 30 : 4),
        color: color,
        boxShadow: _buildBoxShadow(),
      ),
      child: _buildCenteredText(text, height),
    );
  }

  Widget _buildTransparentBox(String text, double height) {
    return Container(
      color: Colors.transparent,
      height: height,
      child: _buildCenteredText(text, height),
    );
  }

  Widget _buildCenteredText(String text, double height) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    );
  }

  List<BoxShadow> _buildBoxShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 0,
        offset: Offset(0, 5),
      ),
    ];
  }
}

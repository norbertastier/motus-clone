import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';

class TitleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 40;
    const List<Color> redColor = gradientCorrectColor;
    const List<Color> orangeColor = gradientInWordColor;

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

  Widget _buildColoredBox(String text, double height, List<Color> gradient,
      {bool circular = false}) {
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular ? 30 : 4),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradient),
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
        style: TextStyle(color: background, fontWeight: FontWeight.w800),
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

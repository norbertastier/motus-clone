import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TitleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double width = 40, height = 40;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xffdb3a34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // La couleur de l'ombre
                  spreadRadius: 0, // L'étendue de l'ombre
                  blurRadius: 0, // Le flou de l'ombre
                  offset: Offset(0, 5), // La position de l'ombre sur l'axe x,y
                ),
              ],
            ),
            child: FittedBox(
              fit:BoxFit.contain,
              child: Text(
                'M',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),
              ),
            )),
        Container(
          color: Colors.transparent,
          height: height,
          child: FittedBox(
            fit:BoxFit.contain,
            child: Text(
              'O',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),
            ),
          ),
        ),
        Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xfff7b735),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // La couleur de l'ombre
                  spreadRadius: 0, // L'étendue de l'ombre
                  blurRadius: 0, // Le flou de l'ombre
                  offset: Offset(0, 5), // La position de l'ombre sur l'axe x,y
                ),
              ],
            ),
            child: FittedBox(
              fit:BoxFit.contain,
              child: Text(
                'T',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),
              ),
            )),
        Container(
          color: Colors.transparent,
          height: height,
          child: FittedBox(
            fit:BoxFit.contain,
            child: Text(
              'U',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),
            ),
          ),
        ),
        Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xffdb3a34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // La couleur de l'ombre
                  spreadRadius: 0, // L'étendue de l'ombre
                  blurRadius: 0, // Le flou de l'ombre
                  offset: Offset(0, 5), // La position de l'ombre sur l'axe x,y
                ),
              ],
            ),
            child: FittedBox(
              fit:BoxFit.contain,
              child: Text(
                'S',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),
              ),
            )),
      ],
    );
  }
}

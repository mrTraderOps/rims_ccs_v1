//styles for all and every pages

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const String fontNameDefault = 'Mina';

class Ui_Colors {
  static const Color lightBlue = Color(0xFFD9EFF7);
  static const Color skyBlue = Color(0xFF9BBBFC);
  static const Color blue = Color(0xFF85ACFF);
  static const Color darkBlue = Color(0xFF4741A6);
  static const Color yellow = Color(0xFFF9CE69);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF3E4051);
}

class Ui_fonts {
  static const TextStyle TitleTextBoldWhite = TextStyle(
  fontFamily: fontNameDefault,
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: Ui_Colors.white
  );

  static const TextStyle TitleTextBoldBlack = TextStyle(
  fontFamily: fontNameDefault,
  fontWeight: FontWeight.bold,
  fontSize: 35,
  color: Ui_Colors.black
  );

  static const TextStyle SmallTitleTextBoldBlack = TextStyle(
  fontFamily: fontNameDefault,
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: Color.fromRGBO(62, 64, 81, 0.758)
  );
}

class RobotBoxesStyles {
  final double height;

  RobotBoxesStyles(this.height);

  TextStyle get robotBoxesStyle => TextStyle(
    fontFamily: 'PressStart2P',
    fontSize: 38,
    height: height,
    color: Ui_Colors.white,
  );
}


// const double BaseTextSize = 16.0;

// double getRelativeSize(double scale) => BaseTextSize * scale;

// final double LargeTextSize = getRelativeSize(1.625);
// final double MediumTextSize = getRelativeSize(1.25);
// final double BodyTextSize = getRelativeSize(1.0);
// final double SmallTextSize = getRelativeSize(0.875);



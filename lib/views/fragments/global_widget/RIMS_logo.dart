// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../styles.dart';

class RimsLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        color: Ui_Colors.white,
        shape: BoxShape.circle
      ),
      child: Center(
        child: Container(
          height: 160,
          width: 160,
          child: Image.asset('assets/images/mini_bot.png', fit: BoxFit.contain,))
      )
    );
  }
}

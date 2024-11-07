// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFormat extends StatelessWidget {
  final String text;

  TextFormat({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      style: TextStyle(
        fontFamily: 'Mina',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
  }
}
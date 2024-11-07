// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Textfieldformat extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;

  Textfieldformat({required this.textController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Ui_Colors.white,
        border: OutlineInputBorder(),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Mina',
        )
      ),
    );
  }
}
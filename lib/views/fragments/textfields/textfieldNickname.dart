// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Textfieldnickname extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;

  Textfieldnickname({required this.textController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLength: 6,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$')), 
      ],
      decoration: InputDecoration(
        filled: true,
        fillColor: Ui_Colors.white,
        border: OutlineInputBorder(),
        hintText: hintText,
        counterText: "",
        hintStyle: TextStyle(
          fontFamily: 'Mina',
        ),
      ),
    );
  }
}

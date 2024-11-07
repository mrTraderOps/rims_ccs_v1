// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class TextformfieldFormat extends StatefulWidget{
  final TextEditingController textcontroller;
  final String labelText;
  final bool obscureText;
  final bool isUpdate;
  

  TextformfieldFormat({
    required this.textcontroller, 
    required this.labelText, 
    required this.obscureText,  
    required this.isUpdate,
    });

  @override
  State<TextformfieldFormat> createState() => _TextformfieldFormatState();
}

class _TextformfieldFormatState extends State<TextformfieldFormat> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textcontroller,
      decoration: InputDecoration(
        labelText: widget.isUpdate? 'New ${widget.labelText}': widget.labelText,
        labelStyle: TextStyle(
            fontFamily: 'Mina',
            color: Ui_Colors.black,
            fontSize: 14
          )
        ),
      obscureText: widget.obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.isUpdate? 'Please enter a new ${widget.labelText}' : 'Please enter a ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
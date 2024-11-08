// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class TextformfieldGroup extends StatefulWidget {
  final TextEditingController textcontroller;
  final String labelText;
  final bool obscureText;
  final bool isUpdate;
  final String? defaultValue; // Optional parameter for default value

  TextformfieldGroup({
    required this.textcontroller,
    required this.labelText,
    required this.obscureText,
    required this.isUpdate,
    this.defaultValue, // Default value for read-only mode
  });

  @override
  State<TextformfieldGroup> createState() => _TextformfieldGroupState();
}

class _TextformfieldGroupState extends State<TextformfieldGroup> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textcontroller,
      decoration: InputDecoration(
        labelText: widget.isUpdate
            ? 'New ${widget.labelText}'
            : widget.labelText,
        labelStyle: TextStyle(
          fontFamily: 'Mina',
          color: Ui_Colors.black,
          fontSize: 14,
        ),
      ),
      obscureText: widget.obscureText,
      readOnly: true, // Make field read-only based on isUpdate
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.isUpdate
              ? 'Please enter a new ${widget.labelText}'
              : 'Please enter a ${widget.labelText}';
        }
        return null;
      },
    );
  }
}

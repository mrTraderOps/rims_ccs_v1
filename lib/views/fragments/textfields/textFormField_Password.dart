// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class TextformfieldPassword extends StatefulWidget{
  final TextEditingController textcontroller;
  final String labelText;
  final bool isUpdate;
  

  TextformfieldPassword({
    required this.textcontroller, 
    required this.labelText, 
    required this.isUpdate,
    });

  @override
  State<TextformfieldPassword> createState() => _TextformfieldFormatState();
}

class _TextformfieldFormatState extends State<TextformfieldPassword> {

  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

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
          ),
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
            ),
          )
        ),
      obscureText: _isObscured,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.isUpdate? 'Please enter a new ${widget.labelText}' : 'Please enter a ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
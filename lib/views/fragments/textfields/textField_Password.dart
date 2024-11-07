// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class TextfieldPassword extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final bool isObscured;

  TextfieldPassword({
    required this.textController,
    required this.hintText,
    this.isObscured = true,
  });

  @override
  State<TextfieldPassword> createState() => _TextfieldPasswordState();
}

class _TextfieldPasswordState extends State<TextfieldPassword> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isObscured;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      obscureText: _isObscured,
      decoration: InputDecoration(
        filled: true,
        fillColor: Ui_Colors.white,
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'Mina',
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _toggleVisibility,
        ),
      ),
    );
  }
}

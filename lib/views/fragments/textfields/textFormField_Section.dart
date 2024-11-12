import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class TextformfieldSection extends StatelessWidget {
  final TextEditingController textcontroller;
  final String labelText;

  TextformfieldSection({
    required this.textcontroller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2), // Limit to 2 characters
        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')), // Allow only uppercase letters and digits
      ],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontFamily: 'Mina',
            color: Ui_Colors.black,
            fontSize: 14
          ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field cannot be empty';
        }
        if (!RegExp(r'^[A-Z]\d$|^\d[A-Z]$').hasMatch(value)) {
          return 'Must contain 1 uppercase letter and 1 digit';
        }
        return null;
      },
    );
  }
}

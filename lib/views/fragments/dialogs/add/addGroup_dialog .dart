// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Password.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Section.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class AddGroupDialog extends StatefulWidget {
  final VoidCallback onAddRefresh;


  AddGroupDialog({
    required this.onAddRefresh,
    });
  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  VoidCallback get _onAddRefresh => widget.onAddRefresh;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _groupNumController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _roleController = TextEditingController(text: 'Group'); // Default role

  final _formKey = GlobalKey<FormState>();
  String? _emailError;

  FirestoreService _firestoreService = FirestoreService();

  Future<void> _registerGroup() async {
  if (_formKey.currentState!.validate()) {
    try {
      await _firestoreService.registerGroup(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        groupNum: _groupNumController.text.trim(),
        section: _sectionController.text.trim(),
      );

      Navigator.of(context).pop();
      
      _onAddRefresh();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account Successfully Registered')));

    } catch (e) {
      print(e); // Handle errors appropriately
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      setState(() {
        _emailError = 'Invalid email format';
      });
      return _emailError;
    }
    setState(() {
      _emailError = null; // Clear error message
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add Account",
        style: TextStyle(
          fontFamily: 'Mina',
          fontSize: 25,
          fontWeight: FontWeight.bold
          ),
        ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                 labelStyle: TextStyle(
                  fontFamily: 'Mina',
                  color: Ui_Colors.black,
                  fontSize: 14
                ),
                errorText: _emailError),
              validator: _validateEmail,
            ),
            TextformfieldPassword(textcontroller: _passwordController, labelText: 'Password', isUpdate: false),
            TextFormField(
              controller: _groupNumController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1), // Limit to 1 character
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: InputDecoration(
                labelText: 'Group Number',
                labelStyle: TextStyle(
                  fontFamily: 'Mina',
                  color: Ui_Colors.black,
                  fontSize: 14,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field cannot be empty';
                }
                if (!RegExp(r'^\d$').hasMatch(value)) { // Ensure exactly one digit
                  return 'Must contain exactly 1 digit';
                }
                return null;
              },
            ),
            TextformfieldSection(textcontroller: _sectionController, labelText: 'Section'),
            TextFormField(
              controller: _roleController,
              style: TextStyle(
                fontFamily: 'Mina',
                color: Ui_Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(
                labelText: 'Role',
                 labelStyle: TextStyle(
                  fontFamily: 'Mina',
                  color: Ui_Colors.black,
                  )
                ),
              readOnly: true, // Role is fixed as "Prof"
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _registerGroup,
          style: ElevatedButton.styleFrom(
              backgroundColor: Ui_Colors.darkBlue,
              ),
          child: Text(
            "Add User",
            style: TextStyle(
              color: Ui_Colors.white
              ),
            ),
        ),
      ],
    );
  }
}

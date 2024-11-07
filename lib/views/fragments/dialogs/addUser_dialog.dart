// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Format.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Password.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class AddUserDialog extends StatefulWidget {
  final VoidCallback onAddRefresh;

  AddUserDialog({required this.onAddRefresh});
  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController(text: "Prof"); // Default role
  final TextEditingController _suffixController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _emailError;

  VoidCallback get _onAddRefresh => widget.onAddRefresh;

  FirestoreService _firestoreService = FirestoreService();

  Future<void> _registerUser() async {
  if (_formKey.currentState!.validate()) {
    try {
      await _firestoreService.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        nickname: _nicknameController.text.trim(),
        suffix: _suffixController.text.trim(),
        title: _titleController.text.trim(),
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
            TextformfieldFormat(textcontroller: _nameController, labelText: 'Name', obscureText: false, isUpdate: false,),
            TextformfieldFormat(textcontroller: _nicknameController, labelText: 'Nickname', obscureText: false, isUpdate: false,),
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
            TextformfieldFormat(textcontroller: _suffixController, labelText: 'Suffix', obscureText: false, isUpdate: false,),
            TextformfieldFormat(textcontroller: _titleController, labelText: 'Title', obscureText: false, isUpdate: false,)
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
          onPressed: _registerUser,
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

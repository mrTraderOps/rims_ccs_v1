// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Format.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Password.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class ChangeCredentialsDialog extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData; // The document ID of the user to be updated
  final VoidCallback onCredentialsUpdated; // Callback to refresh the user list

  ChangeCredentialsDialog({
    required this.userId,
     required this.userData,
    required this.onCredentialsUpdated,
  });

  @override
  _ChangeCredentialsDialogState createState() => _ChangeCredentialsDialogState();
}

class _ChangeCredentialsDialogState extends State<ChangeCredentialsDialog> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _nicknameController = TextEditingController();
  late TextEditingController _suffixController = TextEditingController();
  late TextEditingController _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  bool _isLoading = false;

  FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing user data
    _emailController = TextEditingController(text: widget.userData['email'] ?? '');
    _passwordController = TextEditingController(text: widget.userData['password'] ?? '');
    _nameController = TextEditingController(text: widget.userData['name'] ?? '');
    _nicknameController = TextEditingController(text: widget.userData['nickname'] ?? '');
    _suffixController = TextEditingController(text: widget.userData['suffix'] ?? '');
    _titleController = TextEditingController(text: widget.userData['title'] ?? '');
  }

  Future<void> _updateCredentials() async {
    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true; // Start loading
      });


      try {
        // Call Firestore service to update credentials
        await _firestoreService.updateProfCredentials(
          userId: widget.userId,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
          nickname: _nicknameController.text.trim(),
          suffix: _suffixController.text.trim(),
          title: _titleController.text.trim()
        );

        // Close the dialog and trigger refresh
        Navigator.of(context).pop();
        widget.onCredentialsUpdated();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credentials Successfully Updated')),
        );
      } catch (e) {
        print(e); // Handle errors appropriately
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    _suffixController.dispose();
    _titleController.dispose();
    super.dispose();
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
        "Change User Credentials",
        style: TextStyle(
          fontFamily: 'Mina',
          fontSize: 25,
          fontWeight: FontWeight.bold,
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
                labelText: 'New Email',
                labelStyle: TextStyle(
                  fontFamily: 'Mina',
                  color: Ui_Colors.black,
                  fontSize: 14,
                ),
                errorText: _emailError,
              ),
              validator: _validateEmail,
            ),
            TextformfieldPassword(textcontroller: _passwordController, labelText: 'Password', isUpdate: true),
            TextformfieldFormat(textcontroller: _nameController, labelText: 'Name', obscureText: false, isUpdate: true),
            TextformfieldFormat(textcontroller: _nicknameController, labelText: 'Nickname', obscureText: false, isUpdate: true),
            TextformfieldFormat(textcontroller: _suffixController, labelText: 'Suffix', obscureText: false, isUpdate: true),
            TextformfieldFormat(textcontroller: _titleController, labelText: 'Title', obscureText: false, isUpdate: true),
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
        _isLoading? CircularProgressIndicator() :
        ElevatedButton(
          onPressed: _updateCredentials,
          style: ElevatedButton.styleFrom(
            backgroundColor: Ui_Colors.darkBlue,
          ),
          child: Text(
            "Update Credentials",
            style: TextStyle(color: Ui_Colors.white),
          ),
        ),
      ],
    );
  }
}

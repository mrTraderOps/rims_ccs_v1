// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Password.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Section.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class UpdateGroup extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData; // The document ID of the user to be updated
  final VoidCallback onCredentialsUpdated; // Callback to refresh the user list

  UpdateGroup({
    required this.userId,
     required this.userData,
    required this.onCredentialsUpdated,
  });

  @override
  _UpdateGroupState createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _groupNumController = TextEditingController();
  late TextEditingController _sectionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  bool _isLoading = false;

  FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing user data
    _emailController = TextEditingController(text: widget.userData['Email'] ?? '');
    _passwordController = TextEditingController(text: widget.userData['password'] ?? '');
    _groupNumController = TextEditingController(text: widget.userData['Group Number'] ?? '');
    _sectionController = TextEditingController(text: widget.userData['Section'] ?? '');
  }

  Future<void> _updateCredentials() async {
    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true; // Start loading
      });


      try {
        // Call Firestore service to update credentials
        await _firestoreService.updateGroupCredentials(
          userId: widget.userId,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          groupNum: _groupNumController.text.trim(),
          section: _sectionController.text.trim(),
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
    _groupNumController.dispose();
    _sectionController.dispose();
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
        "Change Group Credentials",
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
            TextFormField(
              controller: _groupNumController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1), // Limit to 1 character
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: InputDecoration(
                labelText: 'New Group No.',
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
            TextformfieldSection(textcontroller: _sectionController, labelText: 'New Section')
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

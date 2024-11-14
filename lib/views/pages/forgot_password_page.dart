// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/login_auth_service.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final LoginAuthService _resetPasswordService = LoginAuthService();

  void _resetPassword() async {
  if (_emailController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter your email address')),
    );
    return;
  }

  final email = _emailController.text.trim();

  // Show a loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );

  try {
    await _resetPasswordService.resetPassword(email);
    // Close the loading dialog
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent successfully!')),
    );
    Navigator.pop(context); // Return to the previous screen
  } catch (error) {
    // Close the loading dialog
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Ui_Colors.darkBlue,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontFamily: 'Mina',
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your email address to reset your password.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
                ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Ui_Colors.darkBlue,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Reset Password',
                style: TextStyle(fontSize: 16, color: Ui_Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

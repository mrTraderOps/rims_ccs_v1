// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/login_auth_service.dart';
import '../fragments/global_widget/rims_logoTitle.dart';
import '../fragments/inputs/login_inputs.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginAuthService _loginAuthService = LoginAuthService();

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kindly fill in both email and password')),
        );

      return;
    }

    // Check if email format is valid
  final email = _emailController.text.trim();
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$'); // Simple regex for email format
  if (!emailRegex.hasMatch(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter a valid email address')),
    );
    return;
  }

    _loginAuthService.login(
    context,
    email,
    _passwordController.text.trim(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ui_Colors.skyBlue,
      body: SafeArea(
        child: Column(
          children: [
            // 1st Box with RIMS_Logo and Title
            Expanded(
              flex: 7,
              child: Center(
                child: RIMSLogoTitle(),
              ),
            ),
            // 2nd Box for Other Content
            Expanded(
              flex: 5,
              child: LoginInputs(
                emailController: _emailController,
                passwordController: _passwordController,
                onLogin: _handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

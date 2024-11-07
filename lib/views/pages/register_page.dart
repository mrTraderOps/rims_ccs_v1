// Inside your login page file
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/controllers/home_screen_controller.dart';
import 'package:rims_ccs_v1/models/services/register_auth_service.dart';
import 'package:rims_ccs_v1/views/fragments/inputs/register_inputs.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _suffixController = TextEditingController();

  Future<void> _register() async {
    final result = await RegisterAuthService().registerUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      nickname: _nicknameController.text,
      title: _titleController.text,
      suffix: _suffixController.text,
    );

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            role: result['role']!,
            nickname: result['nickname']!,
            title: result['title']!,
            name: result['name']!,
            suffix: result['suffix']!,
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully Registered and Logged In')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ui_Colors.skyBlue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'RIMS-CCS',
                      style: Ui_fonts.TitleTextBoldWhite,)
                    ),
                  Text(
                  'Robotics Inventory Management System',
                  style: Ui_fonts.SmallTitleTextBoldBlack,)
                ],
              )
            ),
            Expanded(
              flex: 6,
              child: RegisterInputs(
                emailController: _emailController,
                passwordController: _passwordController,
                nameController: _nameController,
                nicknameController: _nicknameController,
                titleController: _titleController,
                suffixController: _suffixController,
                onRegister: _register,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

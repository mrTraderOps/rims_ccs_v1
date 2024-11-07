// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/TextfieldFormat.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textField_Password.dart';
import '../../styles.dart';

class LoginInputs extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  
  LoginInputs({required this.emailController, required this.passwordController, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Ui_Colors.darkBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.0),
          topRight: Radius.circular(34.0),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontFamily: 'Mina',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Ui_Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Textfieldformat(textController: emailController, hintText: 'Enter your Email'),
                SizedBox(height: 15.0),
                TextfieldPassword(textController: passwordController, hintText: 'Enter Your Password'),
                TextButton(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Ui_Colors.white,
                        fontSize: 15
                      ),
                    ),
                  onPressed: () => {

                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: onLogin,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

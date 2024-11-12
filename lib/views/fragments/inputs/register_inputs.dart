// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textField_Password.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textfieldFormat.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textfieldNickname.dart';
import '../../styles.dart';

class RegisterInputs extends StatelessWidget {

  final TextEditingController emailController, passwordController, nameController, nicknameController, titleController, suffixController;
  final VoidCallback onRegister;

  
  RegisterInputs({
    required this.emailController, 
    required this.passwordController, 
    required this.nameController,
    required this.nicknameController,
    required this.titleController,
    required this.suffixController,
    required this.onRegister,
    });

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                'Register as Admin',
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
                SizedBox(height: 15.0),
                Textfieldformat(textController: emailController, hintText: 'Enter Your Email',),
                SizedBox(height: 15.0),
                TextfieldPassword(textController: passwordController, hintText: 'Enter Your Password'),
                SizedBox(height: 15.0),
                Textfieldformat(textController: nameController, hintText: 'Enter Your Full Name',),
                SizedBox(height: 15.0),
                Textfieldnickname(textController: nicknameController, hintText: 'Enter Your Nickname ( Max. 6 characters)'),
                SizedBox(height: 15.0),
                Textfieldformat(textController: titleController, hintText: 'Enter Your Position',),
                SizedBox(height: 15.0),
                Textfieldformat(textController: suffixController, hintText: 'Enter Your Suffix (Optional)'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('Back'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: onRegister,
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

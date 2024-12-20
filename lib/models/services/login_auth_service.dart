// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(

    BuildContext context,
    String email,
    String password,
  ) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // Authenticate user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Fetch user data from Firestore
      final userDoc =
          await _firestore.collection('users').doc(userCredential.user?.uid).get();

      // Close loading dialog
      Navigator.of(context).pop();

      if (userDoc.exists) {
        String role = userDoc['Role'];
        String title = userDoc['Title'];
        
        if (role == 'Group') {
          String groupNum = userDoc['Group Number'];
          String section = userDoc['Section'];
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'Role': role,
              'Group Number': groupNum,
              'Section': section,
              'Title': title,
            },
          );
        } else {
          String nickname = userDoc['Nickname'];
          String name = userDoc['Name'];
          String suffix = userDoc['Suffix'];
          // Navigate to the HomeScreen
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'Role': role,
              'Nickname': nickname,
              'Title': title,
              'Name': name,
              'Suffix': suffix,
            },
          );
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Logged In')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Login')),
        );
      }
    } catch (e) {
      // Close loading dialog if there's an error
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging in: ${e.toString()}')),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      throw error.toString();
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPageState createState() => _AdminRegistrationPageState();
}

class _AdminRegistrationPageState extends State<AdminRegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerAdmin() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Store user data in Firestore with a role of 'admin'
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'role': 'admin',
        'email': emailController.text.trim(),
        // You can add additional fields here if needed
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Admin registered successfully!')),
      );

      // Navigate to the admin dashboard or another screen
      Navigator.pushReplacementNamed(context, '/profhomepage');
    } catch (e) {
      print('Error registering admin: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering admin: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(onPressed: registerAdmin, child: Text('Register as Admin')),
        ],
      ),
    );
  }
}

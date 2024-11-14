// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String>?> registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String nickname,
    required String title,
    required String suffix,
  }) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Register the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Store additional user information in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'Email': email.trim(),
        'Name': name.trim(),
        'Nickname': nickname.trim(),
        'Role': 'Admin',
        'Title': title.trim(),
        'Suffix': suffix.trim(),
      });

      // Close the loading dialog
      Navigator.of(context).pop();

      // Retrieve user data from Firestore
      final userDoc = await _firestore.collection('users').doc(userCredential.user?.uid).get();

      if (userDoc.exists) {
        return {
          'Role': userDoc['Role'],
          'Nickname': userDoc['Nickname'],
          'Title': userDoc['Title'],
          'Name': userDoc['Name'],
          'Suffix': userDoc['Suffix'],
        };
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: User data not found')),
        );
        return null;
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close dialog on error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      return null;
    }
  }

  Future<String?> fetchAdminKey() async {
    try {
      // Access the 'adminkey' collection and get the specific document
      DocumentSnapshot doc = await _firestore.collection('adminkey').doc('FGnPkdMtUOpaHfL1RWHP').get();

      // Check if the document exists and contains the key
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['key']; // Returns the key value
      } else {
        print('Document does not exist or is empty.');
        return null;
      }
    } catch (e) {
      print('Error fetching admin key: $e');
      return null;
    }
  }
}

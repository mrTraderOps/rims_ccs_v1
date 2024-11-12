// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Fetches current user data from Firestore.
  Future<Map<String, dynamic>?> loadUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userData = await _firestore.collection('users').doc(user.uid).get();
        return userData.data();
      }
      return null;
    } catch (e) {
      print("Error loading user data: $e");
      rethrow; // Allow error handling to be done by the caller
    }
  }

  /// Updates user's nickname, email, and password in Firestore and Firebase Auth.
  Future<void> updateCredentials({
    String? nickname,
    String? email,
    String? password,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Update Firestore nickname
        await _firestore.collection('users').doc(user.uid).update({
          'Nickname': nickname,
        });

        // Update Firebase Authentication email
        if (email != null && email.isNotEmpty) {
          await user.verifyBeforeUpdateEmail(email);
        }

        // Update Firebase Authentication password if provided
        if (password != null && password.isNotEmpty) {
          await user.updatePassword(password);
        }
      }
    } catch (e) {
      print("Error updating credentials: $e");
    }
  }
}


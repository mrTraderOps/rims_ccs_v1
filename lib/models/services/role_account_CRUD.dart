// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance

  // Fetch All Documents under 'users' collection
  Future<List<Map<String, dynamic>>> fetchDocuments(String collectionPath, String role) async {
  String _role = '';

  if (role == 'Admin') {
    _role = 'Prof';
  } else if (role == 'Prof') {
    _role = 'Group';
  }

  QuerySnapshot querySnapshot = await _firestore
      .collection(collectionPath)
      .where('Role', isEqualTo: _role) // Filter documents by 'Role'
      .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id; // Add document ID
    Map<String, dynamic> sortedData = {};

    if (role == 'Admin') {
      sortedData = {
        'Nickname': data['Nickname'],
        'Name': data['Name'],
        'Suffix': data['Suffix'],
        'Title': data['Title'],
        'Email': data['Email'],
        'id': data['id'],
      };
    } else if (role == 'Prof') {
      sortedData = {
        'Group Number': data['Group Number'],
        'Section': data['Section'],
        'Email': data['Email'],
        'id': data['id'],
      };
    }

    return sortedData; // Correctly return sorted data for each document
  }).toList();
}


  // Delete Documents by Id
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  // Register a new Instructor and add to Firestore
  Future<void> registerInstructor({
    required String email,
    required String password,
    required String name,
    required String nickname,
    required String suffix,
    required String title,
    String role = "Prof", // Default role is "Prof"
  }) async {
    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful registration, save user details in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'Email': email,
        'Name': name,
        'Nickname': nickname,
        'Role': role,
        'Suffix': suffix,
        'Title': title,
      });
    } catch (e) {
      print(e); // Handle errors appropriately, e.g., display a message to the user
      throw Exception('Failed to register user: $e');
    }
  }

  // Register a new Group and add to Firestore
  Future<void> registerGroup({
    required String email,
    required String password,
    required String groupNum,
    required String section,
    String role = "Group", // Default role is "Group"
    String title = "BSCS"
  }) async {
    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful registration, save user details in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'Email': email,
        'Group Number': groupNum,
        'Section': section,
        'Title' : '$title - $section',
        'Role': role,
         
      });
    } catch (e) {
      print(e); // Handle errors appropriately, e.g., display a message to the user
      throw Exception('Failed to register user: $e');
    }
  }
  
  // Change Prof Credentials
  Future<void> updateProfCredentials({
  required String userId,
  required String email,
  required String password,
  required String name,
  required String nickname,
  required String suffix,
  required String title,
}) async {
  // Update user details in Firestore without the password
  await _firestore.collection('users').doc(userId).update({
    'Email': email,
    'Name': name,
    'Nickname': nickname,
    'Suffix': suffix,
    'Title': title,
  });

  // Update email and password in Firebase Authentication
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    await user.verifyBeforeUpdateEmail(email); // Sends a verification email before updating the email
    await user.updatePassword(password);       // Updates password in Firebase Auth only
  }
}

  // Change Group Credentials
  Future<void> updateGroupCredentials({
  required String userId,
  required String email,
  required String password,
  required String groupNum,
  required String section,
}) async {
  // Update user details in Firestore without the password
  await _firestore.collection('users').doc(userId).update({
    'Email': email,
    'Group Number': groupNum,
    'Section': section
  });

  // Update email and password in Firebase Authentication
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    await user.verifyBeforeUpdateEmail(email); // Sends a verification email before updating the email
    await user.updatePassword(password);       // Updates password in Firebase Auth only
  }
}
  // Fetch Again UserData by DocID
  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
    return userSnapshot.data() as Map<String, dynamic>;
  }
}

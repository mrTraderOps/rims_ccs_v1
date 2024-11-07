import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance

  // Fetch All Documents under 'users' collection
  Future<List<Map<String, dynamic>>> fetchDocuments(String collectionPath) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(collectionPath)
        .where('role', isEqualTo: 'Prof')  // Filter for documents with role 'Prof'
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Add document ID to the data map
      data.remove('role');

      return data;  // Return the data with 'docId' and filtered by 'role'
    }).toList();
  }

  // Delete Documents by Id
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  // Register a new Instructor and add to Firestore
  Future<void> registerUser({
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
        'email': email,
        'name': name,
        'nickname': nickname,
        'role': role,
        'suffix': suffix,
        'title': title,
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
    'email': email,
    'name': name,
    'nickname': nickname,
    'suffix': suffix,
    'title': title,
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

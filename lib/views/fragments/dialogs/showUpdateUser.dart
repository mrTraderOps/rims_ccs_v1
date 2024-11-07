// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/updateUser.dart';

void showUpdateUserDialog(BuildContext context, String docId, VoidCallback onCredentialsUpdated) {

  FirestoreService _firestoreService = FirestoreService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _firestoreService.getUserData(docId), // Fetch user data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading user data'));
        } else {
          return ChangeCredentialsDialog(
            userId: docId,
            userData: snapshot.data ?? {}, // Pass user data to dialog
            onCredentialsUpdated: onCredentialsUpdated
          );
        }
      },
      );
    },
  );
}
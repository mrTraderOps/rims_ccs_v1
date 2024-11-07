// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';


void showDeleteAccountDialog(BuildContext context, String documentId, String nickname , VoidCallback onDeleteRefresh) {

  final FirestoreService _firestoreService = FirestoreService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Account"),
        content: Text("Are you sure you want to delete $nickname's account? This action cannot be undone."),
        actions: [
          TextButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(
              'Yes',
              style: TextStyle(
                color: Ui_Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
              backgroundColor: Ui_Colors.darkBlue,
              ),
            onPressed: () async {
              await _firestoreService.deleteDocument('users', documentId);
              Navigator.of(context).pop();
              onDeleteRefresh(); 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Instructor\'s account deleted succcessfully')),
              );
            },
          ),
        ],
      );
    },
  );
}

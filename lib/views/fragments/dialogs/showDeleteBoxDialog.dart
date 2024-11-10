// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';

void showDeleteBoxDialog(BuildContext context, String documentId, String title, String BoxNum, VoidCallback onDeleteRefresh) {
  
  final SelectedBoxServiceCrud _firestoreService = SelectedBoxServiceCrud();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete $title"),
        content: Text("Are you sure you want to delete this $title No. $BoxNum ? This action cannot be undone."),
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
              style: TextStyle(color: Ui_Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Ui_Colors.darkBlue,
            ),
            onPressed: () async {
              try {
                // Call the Firestore delete method
                await _firestoreService.deleteDocument('boxes', documentId);

                // Delete all document
                // await _firestoreService.deleteAll('boxes');
                
                
                // Close the dialog
                Navigator.of(context).pop();
                
                // Refresh the UI
                onDeleteRefresh();
                
                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title deleted successfully')),
                );
              } catch (e) {
                // Handle errors gracefully
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete the $title: $e')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

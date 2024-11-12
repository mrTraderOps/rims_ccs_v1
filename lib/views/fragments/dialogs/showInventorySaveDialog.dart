// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

void showInventorySaveDialog(BuildContext context, VoidCallback onCheckandSaveInventory, String titleContainer, String boxNumStr) {
  

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("SAVE INVENTORY"),
        content: Text("Are you sure you want to save the inventory of this $titleContainer No. $boxNumStr? This action cannot be undone."),
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
                
                // Close the dialog
                Navigator.of(context).pop();
                
                // Back to page one
                onCheckandSaveInventory();
                
              } catch (e) {
                // Handle errors gracefully
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to Inventory:$e')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

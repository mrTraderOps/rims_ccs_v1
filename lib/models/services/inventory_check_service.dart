import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryCheckService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check item if missing or excess
  Future<bool> checkAndSaveInventory(
    int originalQty,
    int inputQty,
    String num,
    String itemName,
    String groupNumStr,
    String title,
    String boxNumStr,
    String section,
  ) async {
    String doc = '$title$boxNumStr';
    String docId = 'group$groupNumStr-$doc';
    int diff = inputQty - originalQty;

    bool hasChanges = false;
    
    if (diff == 0) {
    // Delete from both 'missing' and 'excess' if no difference exists
    await deleteItemByNum(num, docId, deleteFromMissing: true, deleteFromExcess: true);
  } else if (diff < 0) {
    // Handle missing: delete from 'excess' and add to 'missing'
    await deleteItemByNum(num, docId, deleteFromExcess: true); // Remove excess item
    await _updateFirestore('/inventory/$docId/missing', num, itemName, diff.abs());
    hasChanges = true;
  } else if (diff > 0) {
    // Handle excess: delete from 'missing' and add to 'excess'
    await deleteItemByNum(num, docId, deleteFromMissing: true); // Remove missing item
    await _updateFirestore('/inventory/$docId/excess', num, itemName, diff);
    hasChanges = true;
  }


    return hasChanges; // Return if changes were made
  }

  // Checked item will be saved to Firestore, except to complete item
  Future<void> _updateFirestore(String collectionPath, String num, String itemName, int qty) async {
    try {
      final documentReference = _firestore.collection(collectionPath).doc();
      await documentReference.set({
        'num': num,
        '_itemName': itemName,
        'qty': qty.toString(),
      });

      print('The item Number : $num, _itemName : $itemName, Qty : $qty in Inserted to Database');


    } catch (e) {
      print("Error saving data: $e");
    }
  }

  // Record History of Inventory
  Future<void> recordData(String docId, String section, String group, String remarks) async {
    try {

      final DateTime now = DateTime.now();

      await _firestore.collection('/inventory/$docId/records').doc().set({
        'Date': Timestamp.fromDate(now),
        'Section': section,
        'Group': group,
        'Remarks': remarks,
      });

      print('Log recorded: Date: $now, Section: $section, Group: $group, Remarks: $remarks');
      }
      catch (e) {
      print("Error recording log: $e");
    }
  }

  //Final Checking of Box/Module
  Future<void> statusBoxModule(String docId) async {
    try {
      String remarks;
      // Check for documents in 'missing' collection
      final missingSnapshot = await _firestore.collection('/inventory/$docId/missing').get();
      bool hasMissing = missingSnapshot.docs.isNotEmpty;

      // Check for documents in 'excess' collection
      final excessSnapshot = await _firestore.collection('/inventory/$docId/excess').get();
      bool hasExcess = excessSnapshot.docs.isNotEmpty;

      // Determine remarks based on missing and excess status
      if (hasMissing && hasExcess) {
        remarks = 'INCOMPLETE';
      } else if (hasMissing) {
        remarks = 'MISSING';
      } else if (hasExcess) {
        remarks = 'EXCESS';
      } else {
        remarks = 'COMPLETE';
      }

      // Update the status in the main document
      await _firestore.collection('/inventory').doc(docId).update({
        'status': remarks,
      });

      print('Status updated to: $remarks for $docId.');
    } catch (e) {
      print("Error updating status: $e");
    }
  }

  // Check first the box or module
  Future<String> checkBoxModule(String docId) async {
    try {
      String remarks;
      // Check for documents in 'missing' collection
      final missingSnapshot = await _firestore.collection('/inventory/$docId/missing').get();
      bool hasMissing = missingSnapshot.docs.isNotEmpty;

      // Check for documents in 'excess' collection
      final excessSnapshot = await _firestore.collection('/inventory/$docId/excess').get();
      bool hasExcess = excessSnapshot.docs.isNotEmpty;

      // Determine remarks based on missing and excess status
      if (hasMissing && hasExcess) {
        remarks = 'EXCESS & MISSING';
      } else if (hasMissing) {
        remarks = 'MISSING';
      } else if (hasExcess) {
        remarks = 'EXCESS';
      } else {
        remarks = 'COMPLETE';
        
      }

      print('Status updated to: $remarks for $docId.');

      return remarks;
    } catch (e) {
      print("Error updating status: $e");
      return 'ERROR IN CHECK BOX';
    }
  }

  // Delete Item by Num
  Future<void> deleteItemByNum(String num, String docId, {bool deleteFromMissing = true, bool deleteFromExcess = true}) async {
  final String missingPath = 'inventory/$docId/missing';
  final String excessPath = 'inventory/$docId/excess';

  try {
    // Helper function to delete documents by 'num' in a specified collection
    Future<void> _deleteFromCollection(String collectionPath) async {
      final querySnapshot = await _firestore
          .collection(collectionPath)
          .where('num', isEqualTo: num)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
          print('Document with num: $num deleted successfully from $collectionPath.');
        }
      } else {
        print('No document found with num: $num in $collectionPath.');
      }
    }

    // Execute based on the parameters
    if (deleteFromMissing) await _deleteFromCollection(missingPath);
    if (deleteFromExcess) await _deleteFromCollection(excessPath);

  } catch (e) {
    print("Error deleting data: $e");
  }
}

  // Delete All Inventory Caller
  Future<void> deleteInventoryData(String groupNumStr, String title, String boxNumStr) async {
  String docId = 'group$groupNumStr-${title.toLowerCase()}$boxNumStr';

  try {
    final missingCollection = _firestore.collection('/inventory/$docId/missing');
    final excessCollection = _firestore.collection('/inventory/$docId/excess');

    // Delete all documents in the "missing" collection
    await _deleteAllDocuments(missingCollection);

    // Delete all documents in the "excess" collection
    await _deleteAllDocuments(excessCollection);

    print('All missing and excess data deleted for $docId.');
  } catch (e) {
    print('Error deleting data: $e');
  }
}

  // Delete All Inventory Function
  Future<void> _deleteAllDocuments(CollectionReference collection) async {
  final snapshot = await collection.get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}
}

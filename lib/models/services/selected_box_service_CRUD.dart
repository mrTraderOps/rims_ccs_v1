// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SelectedBoxServiceCrud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all values under 'boxes' collection
 Future<List<List<dynamic>>> fetchDocumentValues(String collectionPath, String groupNum) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(collectionPath)
      .where('group', isEqualTo: groupNum) // Filter by group field
      .orderBy('boxNum') // Sort documents by boxNum in ascending order
      .get();

  // Define the desired key order
  const List<String> keyOrder = ['boxNum', 'status', 'section'];

  // Extract values based on the specified order and include docId
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Append the document ID to the ordered values
    return [...keyOrder.map((key) => data[key]), doc.id];
  }).toList();
}

 // Add box based on group number
  Future<void> addBox({
    required String boxNum,
    required String group,
    required String section,
    required String status,
    required String title,
    

  }) async {
    try {
      await _firestore.collection('inventory').doc('group$group-$title$boxNum').set({
        'boxNum': boxNum,
        'group': group,
        'section': section,
        'status': status,
      });
    } catch (e) {
      print(e); // Handle errors appropriately, e.g., display a message to the user
      throw Exception('Failed to add Box $e');
    }
  }

   // Delete Documents by Id
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  // Delete all docId
  Future<void> deleteAll(String collectionPath) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      for (var doc in querySnapshot.docs) {
        await _firestore.collection(collectionPath).doc(doc.id).delete();
      }
    } catch (e) {
      print('Error deleting documents: $e');
    }
  }

  // Fetch Item According to location
  Future<List<List<dynamic>>> fetchItemData(String collectionPath) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(collectionPath)
      .orderBy('num')
      .get();


  // Define the desired key order
  const List<String> keyOrder = ['num', '_itemName', 'qty'];

  // Extract values based on the specified order and include docId
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Append the document ID to the ordered values
      return [...keyOrder.map((key) => data[key])];
    }).toList();
  }

  //
  Future<List<List<dynamic>>> fetchRecordData(String collectionPath) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(collectionPath)
      .orderBy('Date', descending: true) // Order by date in descending order
      .get();

  // Define the desired key order
  const List<String> keyOrder = ['Date', 'Section', 'Group', 'Remarks'];

  // Extract values based on the specified order and format the date
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Format the date from Timestamp
    final Timestamp timestamp = data['Date'];
    final formattedDate = DateFormat('hh:mma - dd/MM')
      .format(timestamp.toDate().toLocal());

    // Replace the original 'date' value with the formatted date
    return [
      formattedDate,
      ...keyOrder.skip(1).map((key) => data[key])
    ];
  }).toList();
}

  // Insert Module Parts into Firestore
  Future<void> insertModuleParts() async {
    try {
      // List of parts with their corresponding quantities
      List<Map<String, dynamic>> parts = [
      {'num': 1, '_itemName': 'DC MOTOR DRIVE BOARD', 'qty': 1},
      {'num': 2, '_itemName': 'BLUETOOTH TRANSMITTER', 'qty': 1},
      {'num': 3, '_itemName': 'BLUETOOTH BOARD', 'qty': 1},
      {'num': 4, '_itemName': 'BLUETOOTH MODULE', 'qty': 2},
      {'num': 5, '_itemName': 'PING PONG BALL', 'qty': 1},
      {'num': 6, '_itemName': 'S HOOK 30MM', 'qty': 5},
      {'num': 7, '_itemName': 'S HOOK 35MM', 'qty': 5},
      {'num': 8, '_itemName': 'L2x2 FRAME', 'qty': 1},
      {'num': 9, '_itemName': '15MM SUPPORT', 'qty': 2},
      {'num': 10, '_itemName': '25MM SUPPORT', 'qty': 2},
      {'num': 11, '_itemName': 'BATTLE WEAPON G', 'qty': 1},
      {'num': 12, '_itemName': 'MIDDLE FRAME(PCB)', 'qty': 1},
      {'num': 13, '_itemName': '5 HOLE FRAME', 'qty': 2},
      {'num': 14, '_itemName': '3 HOLE FRAME', 'qty': 2},
      {'num': 15, '_itemName': '3 PIN CABLE', 'qty': 6},
      {'num': 16, '_itemName': '4 PIN CABLE', 'qty': 1},
    ];
      // Create a Map with 'Parts' as the key and the list of parts as the value
      Map<String, dynamic> moduleData = {
        'Parts': parts,
      };

      // Insert the data into Firestore under '/modules/module1'
      await _firestore.collection('modules').doc('module5').set(moduleData, SetOptions(merge: true));

      print('Module parts successfully inserted!');
    } catch (e) {
      print('Error inserting Module parts: $e');
      throw Exception('Failed to insert Module parts');
    }
  }

  // Fetch ModuleParts
  Future<List<Map<String, dynamic>>> fetchModuleParts(String moduleNum) async {
    try {
      // Fetch the document from the Firestore collection
      DocumentSnapshot documentSnapshot = await _firestore.collection('modules').doc('module$moduleNum').get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the 'Parts' field from the document
        List<dynamic> partsList = documentSnapshot['Parts'];

        // Convert the dynamic list to a list of maps
        List<Map<String, dynamic>> parts = List<Map<String, dynamic>>.from(partsList);

        return parts;
      } else {
        throw Exception('Module1 parts not found');
      }
    } catch (e) {
      print('Error fetching Module1 parts: $e');
      throw Exception('Failed to fetch Module1 parts');
    }
  }
}

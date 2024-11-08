import 'package:cloud_firestore/cloud_firestore.dart';

class SelectedBoxServiceCrud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all values under 'boxes' collection
 Future<List<List<dynamic>>> fetchDocumentValues(String collectionPath) async {
  QuerySnapshot querySnapshot = await _firestore
      .collection(collectionPath)
      .orderBy('boxNum') // Sort documents by boxNum in ascending order
      .get();

  // Define the desired key order
  const List<String> keyOrder = ['boxNum', 'status', 'section', 'group'];

  // Extract values based on the specified order
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Add docId as the first item in the list
    List<dynamic> values = [doc.id];

    // Map values based on the predefined order
    values.addAll(keyOrder.map((key) => data[key]).toList());

    return values;
  }).toList();
}




  Future<void> addBox({
    required String boxNum,
    required String group,
    required String section,
    required String status,
    

  }) async {
    try {
      await _firestore.collection('boxes').doc().set({
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
}

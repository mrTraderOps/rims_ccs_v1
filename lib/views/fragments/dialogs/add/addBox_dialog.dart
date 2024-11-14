// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Format.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_GroupNum.dart';
import 'package:rims_ccs_v1/views/styles.dart';
import 'package:flutter/services.dart'; 

class AddBoxDialog extends StatefulWidget {

  final VoidCallback onAddRefresh;
  final String title;
  final String groupNumStr;

  AddBoxDialog({
    required this.onAddRefresh,
    required this.title,
    required this.groupNumStr
    });

  @override
  _AddBoxDialogState createState() => _AddBoxDialogState();
}

class _AddBoxDialogState extends State<AddBoxDialog> {

  String groupNum = '';

  String get _groupNumStr => widget.groupNumStr;

  final TextEditingController _boxNumController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController(text: '4A & 4B');
  final TextEditingController _statusController = TextEditingController(text: 'INCOMPLETE');

  late TextEditingController _groupController;

  final _formKey = GlobalKey<FormState>();

  SelectedBoxServiceCrud _firestoreService = SelectedBoxServiceCrud();

  @override
  void initState() {
    super.initState();
    _groupController = TextEditingController(text: _groupNumStr);
  }


  VoidCallback get _onAddRefresh => widget.onAddRefresh;
  String get _title => widget.title;

  Future<void> _addBox() async {
  if (_formKey.currentState!.validate()) {
    try {
      await _firestoreService.addBox(
        boxNum: _boxNumController.text.trim(),
        group:  _groupController.text.trim(),
        section: _sectionController.text.trim(),
        status: _statusController.text.trim(),
        title: _title.toLowerCase()
      );

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Box Successfully Added')));

      _onAddRefresh();

    } catch (e) {
      print(e); // Handle errors appropriately
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add $_title",
        style: TextStyle(
          fontFamily: 'Mina',
          fontSize: 25,
          fontWeight: FontWeight.bold
          ),
        ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                controller: _boxNumController,
                decoration: InputDecoration(
                  labelText: '$_title Number',
                  labelStyle: TextStyle(
                    fontFamily: 'Mina',
                    color: Ui_Colors.black,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a $_title Number';
                  }
                  // Check if input is a single digit between 0-5
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue < 0 || intValue > 5) {
                    return 'Please enter a digit between 0 and 5';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(1),    // Limit input to 1 character
                ],
              ),
            TextformfieldGroup(textcontroller: _groupController, labelText: 'Group', obscureText: false, isUpdate: false,),
            TextformfieldFormat(textcontroller: _sectionController, labelText: 'Section', obscureText: false, isUpdate: false,),
            TextformfieldFormat(textcontroller: _statusController, labelText: 'Status', obscureText: false, isUpdate: false,),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _addBox,
          style: ElevatedButton.styleFrom(
              backgroundColor: Ui_Colors.darkBlue,
              ),
          child: Text(
            "Add $_title",
            style: TextStyle(
              color: Ui_Colors.white
              ),
            ),
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormField_Format.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class AddBoxDialog extends StatefulWidget {

  final VoidCallback onAddRefresh;

  AddBoxDialog({required this.onAddRefresh});

  @override
  _AddBoxDialogState createState() => _AddBoxDialogState();
}

class _AddBoxDialogState extends State<AddBoxDialog> {
  final TextEditingController _boxNumController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SelectedBoxServiceCrud _firestoreService = SelectedBoxServiceCrud();

  VoidCallback get _onAddRefresh => widget.onAddRefresh;

  Future<void> _addBox() async {
  if (_formKey.currentState!.validate()) {
    try {
      await _firestoreService.addBox(
        boxNum: _boxNumController.text.trim(),
        group:  _groupController.text.trim(),
        section: _sectionController.text.trim(),
        status: _statusController.text.trim(),
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
        "Add Box",
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
            TextformfieldFormat(textcontroller: _boxNumController, labelText: 'Box Number', obscureText: false, isUpdate: false,),
            TextformfieldFormat(textcontroller: _groupController, labelText: 'Group Number', obscureText: false, isUpdate: false,),
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
            "Add Box",
            style: TextStyle(
              color: Ui_Colors.white
              ),
            ),
        ),
      ],
    );
  }
}

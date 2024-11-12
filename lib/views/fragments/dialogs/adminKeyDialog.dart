import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/register_auth_service.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class AdminKeyDialog extends StatefulWidget {
  @override
  _AdminKeyDialogState createState() => _AdminKeyDialogState();
}

class _AdminKeyDialogState extends State<AdminKeyDialog> {
  final TextEditingController adminKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegisterAuthService _registerService = RegisterAuthService();
  bool _isKeyValid = true; // Flag for key validation

  Future<void> _validateAdminKey() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? adminkey = await _registerService.fetchAdminKey();

        print(adminkey);

        if (adminkey == adminKeyController.text) {
          setState(() {
            _isKeyValid = true; // Reset if valid
          });
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/register');
        } else {
          setState(() {
            _isKeyValid = false; // Set to false if invalid
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Please provide Admin Key to Register",
        style: TextStyle(
          fontFamily: 'Mina',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: adminKeyController,
              style: TextStyle(
                fontFamily: 'Mina',
                color: Ui_Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Admin Key',
                labelStyle: TextStyle(
                  fontFamily: 'Mina',
                  color: Ui_Colors.black,
                ),
                errorText: _isKeyValid ? null : 'Incorrect Admin Key',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isKeyValid ? Ui_Colors.lightBlue : Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _isKeyValid ? Ui_Colors.lightBlue : Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _validateAdminKey,
          style: ElevatedButton.styleFrom(
            backgroundColor: Ui_Colors.darkBlue,
          ),
          child: Text(
            "Submit",
            style: TextStyle(color: Ui_Colors.white),
          ),
        ),
      ],
    );
  }
}

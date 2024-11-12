// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/profile_setting_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/global_widget/RIMS_logo.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textField_Password.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textFormat.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textfieldFormat.dart';
import 'package:rims_ccs_v1/views/fragments/textfields/textfieldNickname.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class AccountSetting extends StatefulWidget {
  final String name, title, suffix;
  final Function (String) updateNickname;

  AccountSetting({
    Key? key, 
    required this.name, 
    required this.title, 
    required this.suffix,
    required this.updateNickname,
    }): super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Function get _updateNickname  => widget.updateNickname;

  bool _isLoading = false;

  String _nicknameHint = ''; 
  String _emailHint = '';

  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // _emailHint;
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    final currentContext = context;

    try {
      final data = await firestoreService.loadUserData();
      if (data != null) {
        
        setState(() {
          _nicknameHint = data['Nickname'] ?? '';  
          _emailHint = _auth.currentUser?.email ?? '';
          _updateNickname(_nicknameHint);

          _nicknameController.clear();
        });
      }

      
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Failed to load user data.')),
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _updateCredentials() async {
    setState(() => _isLoading = true);
    final currentContext = context;

    try {
      // Call the service to update Firebase credentials
      await firestoreService.updateCredentials(
        nickname: _nicknameController.text.isNotEmpty ? _nicknameController.text.trim() : null,
        email: _emailController.text.isNotEmpty ? _emailController.text.trim() : null,
        password: _passwordController.text.isNotEmpty ? _passwordController.text.trim() : null,
      );

      _loadUserData();

      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Credentials updated successfully.')),
      );

    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Error updating credentials.')),
      );
    }
    setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Container(
              color: Ui_Colors.skyBlue,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  RimsLogo(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            '${widget.name}, ${widget.suffix}',
                            style: TextStyle(
                              fontFamily: 'Mina',
                              fontWeight: FontWeight.w700,
                              fontSize: 27,
                              color: Ui_Colors.black,
                            ),
                          ),
                          Text(
                            widget.title,
                            style: Ui_fonts.SmallTitleTextBoldBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: Ui_Colors.skyBlue,
            child: Container(
              decoration: BoxDecoration(
                color: Ui_Colors.darkBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34.0),
                  topRight: Radius.circular(34.0),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormat(text: 'Change Nickname'),
                          Textfieldnickname(textController: _nicknameController, hintText: '$_nicknameHint ( Max. 6 characters)'),
                          SizedBox(height: 10),
                          TextFormat(text: 'Change Email'),
                          Textfieldformat(textController: _emailController, hintText: _emailHint,),
                          SizedBox(height: 10),
                          TextFormat(text: 'Password'),
                          TextfieldPassword(textController: _passwordController, hintText: 'Change Password', isObscured: true),
                          SizedBox(height: 30),
                          Center(
                            child: Container(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: _updateCredentials,
                                child: _isLoading ? CircularProgressIndicator() 
                                : Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 16
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

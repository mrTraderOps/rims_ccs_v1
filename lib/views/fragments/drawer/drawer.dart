// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/pages/login_page.dart';
import 'drawer_nav.dart';
import '../../styles.dart';

class DrawerFragment extends StatefulWidget {
  final Function(int) onSelectTab;
  final String role;

  DrawerFragment({required this.onSelectTab, required this.role});

  @override
  State<DrawerFragment> createState() => _DrawerFragmentState();
}

class _DrawerFragmentState extends State<DrawerFragment> {
  int index = 0;
  String get _role => widget.role;

  void _onTabBody(int i) {
    setState(() {
      index = i;
    });
    widget.onSelectTab(index);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully Signed Out')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        drawer_nav('HOME', onTap: () => _onTabBody(0)),
        
        // Conditionally show "PROFILE SETTING" and "INSTRUCTOR ACCOUNT"
        if (_role == 'Admin' || _role == 'Prof') 
          drawer_nav('PROFILE SETTING', onTap: () => _onTabBody(1)),
        
        if (_role == 'Admin' || _role == 'Prof') 
          drawer_nav('INSTRUCTOR ACCOUNT', onTap: () => _onTabBody(2)),

        Spacer(),

        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Ui_Colors.skyBlue,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 53, 53, 53).withOpacity(0.8),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/logout_icon.png', fit: BoxFit.contain),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: _signOut,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Mina',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Ui_Colors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

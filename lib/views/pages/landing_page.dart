// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showAdminkeyDialog.dart';
import 'package:rims_ccs_v1/views/fragments/global_widget/RIMS_logo.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ui_Colors.darkBlue,
      body: SafeArea(
        child: Column(
          children: [
            // 1st Box with RIMS_Logo and Title
            Expanded(
              flex: 7,
              child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RimsLogo(),
                    SizedBox(height: 20),
                    Text('ROBOTRACK', style: Ui_fonts.TitleTextBoldWhite,),
                    Text('Robotics Inventory Management System', style: Ui_fonts.SmallTitleTextBoldSkyBlue),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 83.0, vertical: 15.0),
                            backgroundColor: Ui_Colors.lightBlue,
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                              ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => showAdminKeyDialog(context),
                          child: Text('Register as Admin'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                            backgroundColor: Ui_Colors.lightBlue,
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            // 2nd Box for Other Content
          ],
        ),
      ),
    );
  }
}

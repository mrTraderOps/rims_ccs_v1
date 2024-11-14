import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showAdminkeyDialog.dart';
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
                    Image.asset(
                      'assets/images/robotlanding.png',
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ROBOTRACK',
                      style: Ui_fonts.LargeTitleTextBoldWhite,
                    ),
                    SizedBox(height: 30),

                    // Ensure buttons are of the same width
                    SizedBox(
                      width: 200, // Specify desired width
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: Ui_Colors.lightBlue,
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200, // Ensure the same width
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: ElevatedButton(
                          onPressed: () => showAdminKeyDialog(context),
                          child: Text('Register as Admin'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: Ui_Colors.lightBlue,
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

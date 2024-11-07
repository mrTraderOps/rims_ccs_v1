// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../styles.dart';

class drawer_nav extends StatelessWidget {

  final String navTitle;
  final VoidCallback onTap;

  drawer_nav(this.navTitle, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 0, 0), // Adjusts spacing around text
      child: Container(
        decoration: BoxDecoration(
          color: Ui_Colors.darkBlue,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 46, 38, 71).withOpacity(0.5), // Shadow color with opacity
              spreadRadius: 3, // How much the shadow should spread
              blurRadius: 2,  // How blurred the shadow should be
              offset: Offset(7, 0), // Horizontal and vertical offset of the shadow              
            )
          ],
        ),
        child: ListTile(
          title:  Text(
            navTitle,
            style: TextStyle(
              fontFamily: 'Mina',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Ui_Colors.white
            ),
          ),
          onTap: onTap
        ),  
      )
    );
  }
}
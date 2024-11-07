// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BoxGroupSection extends StatelessWidget {

  final String section;

  BoxGroupSection(this.section); 

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(top: 10,bottom: 5),
      child: Text(
              'Section : $section',
              style: TextStyle(
                fontFamily: 'Mina',
                color: Color.fromRGBO(28, 27, 45, 0.81),
                fontSize: 14,
              ),
            )
    );
  }
}
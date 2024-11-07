// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BoxNumber extends StatelessWidget {

  final String boxNum, title;

  BoxNumber(this.title, this.boxNum); 

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(top: 10,bottom: 5),
      child: Text(
              '$title No. $boxNum',
              style: TextStyle(
                fontFamily: 'Mina',
                color: Color.fromRGBO(28, 27, 45, 0.81),
                fontSize: 14,
              ),
            )
    );
  }
}
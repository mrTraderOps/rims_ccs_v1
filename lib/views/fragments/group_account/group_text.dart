// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GroupText extends StatelessWidget{

  final String title, value;

  GroupText(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    
    return Text(
      '$title : $value',
      style: TextStyle(
        fontFamily: 'Mina',
        fontSize: 16
      ),
    );
  }
}
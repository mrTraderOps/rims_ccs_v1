// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BoxNumber extends StatefulWidget {

  final String boxNum, title;

BoxNumber({required this.boxNum, required this.title}); 

  @override
  State<BoxNumber> createState() => _BoxNumberState();
}

class _BoxNumberState extends State<BoxNumber> {

  String get _title => widget.title;
  String get _boxNum => widget.boxNum;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(top: 10,bottom: 5),
      child: Text(
              '$_title No. $_boxNum',
              style: TextStyle(
                fontFamily: 'Mina',
                color: Color.fromRGBO(28, 27, 45, 0.81),
                fontSize: 14,
              ),
            )
    );
  }
}
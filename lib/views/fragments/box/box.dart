// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box_data.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Box extends StatefulWidget{
  final List<dynamic> boxData;
  final Function (int) onSelectedBox;
  // final String title;

  Box({required this.onSelectedBox, required this.boxData});
  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {

  Function get _onSelectedBox => widget.onSelectedBox;
  List<dynamic> get _boxData => widget.boxData;
  // String get _title => widget.title;

  @override
  Widget build(BuildContext context) {
    
    return TextButton(
      onPressed: () => _onSelectedBox(4), 
      child: Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Container(
            width: 350,
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Ui_Colors.blue,
              boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7), // Shadow color with opacity
                      spreadRadius: 3, // Spread radius
                      blurRadius: 3, // Blur radius
                      offset: Offset(0, 2), // Offset in x and y direction
                    ),
                  ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 135,
                  width: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Ui_Colors.white
                  ),
                  child: Image.asset('assets/images/boxes/box1.png', fit: BoxFit.contain),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: 135,
                    width: 160,
                    child: BoxData(data: _boxData),
                  ),
                )
              ],
            ),
          ),  
        )
      );
  }
}
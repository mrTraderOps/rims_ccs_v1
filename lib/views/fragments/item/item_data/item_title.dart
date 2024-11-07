// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import '../../../styles.dart';


class Itemtitle extends StatelessWidget{
  

  double Boxheight = 70.0;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.yellow,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.yellow   
                  )
                )
              ),
              child: Center(
                child: Text(
                  'JPG',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ),
            )
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.yellow,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.black    
                  )
                )
              ),
              child: Center(child: Text(
                  'ITEM NAME',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold
                    ),
                  )
                ),
            )
          ),
          Expanded(
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.yellow,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.yellow    
                  )
                )
              ),
              child: Center(
                child: Text(
                  'QTY',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold
                    ),
                  ),
              )
            )
          )
        ]
      )
    );
  }
}
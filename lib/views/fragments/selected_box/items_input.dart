// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class ItemsInput extends StatelessWidget{

  final String pic_part;
  final String name_part;

  double Boxheight = 70.0;

  ItemsInput (this.pic_part, this.name_part);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.white,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.black    
                  )
                )
              ),
              child: Center(child: Text(pic_part)),
            )
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.white,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.black    
                  )
                )
              ),
              child: Center(child: Text(name_part)),
            )
          ),
          Expanded(
            child: Container(
              height: Boxheight,
              decoration: BoxDecoration(
                color: Ui_Colors.white,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Ui_Colors.black    
                  )
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
              ),
            )
          )
        ]
      )
    );
  }
}
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import '../../../styles.dart';
import '../../selected_box/item_count.dart';

class ItemsData extends StatelessWidget{
  
  final String pic_part;
  final String name_part;
  final String count_part;

  double Boxheight = 70.0;

  ItemsData (this.pic_part, this.name_part, this.count_part);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
              child: ItemCount(count_part),
            )
          )
        ]
      )
    );
  }
}
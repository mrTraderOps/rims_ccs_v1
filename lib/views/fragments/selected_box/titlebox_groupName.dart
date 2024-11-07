// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../styles.dart';

class TitleboxGroupname extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Ui_Colors.skyBlue,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Ui_Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BOX NO. 1', 
                              style: TextStyle(
                                fontFamily: 'Mina',
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: Ui_Colors.black
                              )
                              ),
                            Text(
                              'GROUP NO. 1',
                              style: TextStyle(
                                fontFamily: 'Mina',
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Ui_Colors.black
                                )
                              ), 
                          ],  
                        ),
                      ),
                    ),
                  )  
                ],
              ),
    );
  }
}
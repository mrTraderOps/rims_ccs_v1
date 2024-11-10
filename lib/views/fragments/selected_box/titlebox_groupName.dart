// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../styles.dart';

class TitleboxGroupname extends StatefulWidget{
  final String boxNumStr, groupNumStr, title;

  TitleboxGroupname({
    required this.boxNumStr,
    required this.groupNumStr,
    required this.title,
  });
  
  @override
  State<TitleboxGroupname> createState() => _TitleboxGroupnameState();
}

class _TitleboxGroupnameState extends State<TitleboxGroupname> {

  String get _boxNumStr => widget.boxNumStr; 
  String get _groupNumStr => widget.groupNumStr ;
  String get _title => widget.title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Ui_Colors.yellow
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Image.asset('assets/images/robot_box_info.png'),
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
                                'GROUP NO. $_groupNumStr',
                                style: TextStyle(
                                  fontFamily: 'Mina',
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Ui_Colors.black
                                  )
                                ),
                              Text(
                                '$_title NO. $_boxNumStr', 
                                style: TextStyle(
                                  fontFamily: 'Mina',
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
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
              ),
    );
  }
}
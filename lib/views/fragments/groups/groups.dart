// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/groups/group.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Groups extends StatefulWidget {
  final Function(int, int) onSelectGroup;

  Groups({required this.onSelectGroup});
  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {

Color lightGreen = Color(0xFF9BFF85);
Color orange = Color(0xFFF09F53); // Orange
Color lightBlue = Color(0xFF98D1FF); // Light Blue
Color lightRed = Color(0xFFFF8587); // Light Red
Color purple = Color(0xFFA585FF); // Purple
Color lightYellow = Color(0xFFFDFF89); // Light Yellow

Function(int, int) get _onSelectGroup => widget.onSelectGroup;

@override
Widget build(BuildContext context) {

  final robotBoxes1 = RobotBoxesStyles(0.9);
  final robotBoxes2 = RobotBoxesStyles(1.1);

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Container(
              height: 150,
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xFFFFBC2F),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FRELEC',
                    style: robotBoxes1.robotBoxesStyle,
                  ),
                  Text(
                    'GROUPS',
                    style: robotBoxes2.robotBoxesStyle,
                  ),
                ],
              )),
        ),
        Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30)),
                  color: Ui_Colors.white,
                ),
                child: ListView(
                  padding: EdgeInsets.only(top: 30),
                  children: [
                    Group(num: 1, color: lightGreen, onSelectGroup: _onSelectGroup),
                    Group(num: 2, color: orange, onSelectGroup: _onSelectGroup),
                    Group(num: 3, color: lightBlue, onSelectGroup: _onSelectGroup),
                    Group(num: 4, color: lightRed, onSelectGroup: _onSelectGroup),
                    Group(num: 5, color: purple, onSelectGroup: _onSelectGroup),
                    Group(num: 6, color: lightYellow, onSelectGroup: _onSelectGroup),
                  ],
                ),
              ),

            )
          ),
      ],
    ),
  );
  }
}
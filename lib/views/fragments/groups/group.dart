// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Group extends StatefulWidget {
  final Color color;
  final Function(int, int) onSelectGroup;
  final int num;

  Group({required this.num, required this.color, required this.onSelectGroup});

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {

  Function(int, int) get _onSelectGroup => widget.onSelectGroup;
  int get _num => widget.num;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () => _onSelectGroup(4, _num),
          child: Container(
            height: 90,
            width: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7), // Shadow color with opacity
                  spreadRadius: 1, // Spread radius
                  blurRadius: 2, // Blur radius
                  offset: Offset(0, 3), // Offset in x and y direction
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Ui_Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7), // Shadow color with opacity
                        spreadRadius: 1, // Spread radius
                        blurRadius: 3, // Blur radius
                        offset: Offset(1, 4), // Offset in x and y direction
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                            'assets/images/mini_bot.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                SizedBox(width: 20,),
                Center(
                  child: Text(
                    'Group ${widget.num}',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 27, 45, 0.81),
                      fontFamily: 'Mina',
                      fontSize: 25,
                      fontWeight: FontWeight.bold    
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
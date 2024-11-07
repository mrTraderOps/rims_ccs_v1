// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Box1 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 62, 34, 187),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Image.asset('assets/images/mini_bot.png'),
              height: 180,
            ),
          ),
          Container(
            child: Text(
              "Successfully Saved",
              style: TextStyle(
                color: Colors.white
              ),
              ),
          )
        ],
      ),
    );
  }
}
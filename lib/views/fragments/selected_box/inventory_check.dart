// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'items_input.dart';

class InventoryCheck extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
         ItemsInput('0', 'Capnut'),
         ItemsInput('1', 'DC Motor'),
         ItemsInput('2', 'AC Motor')
       ]
    );
  }
}
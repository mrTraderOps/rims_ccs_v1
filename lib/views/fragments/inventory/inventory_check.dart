// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../selected_box/items_input.dart';

class InventoryCheck extends StatefulWidget {

  @override
  State<InventoryCheck> createState() => _InventoryCheckState();
}

class _InventoryCheckState extends State<InventoryCheck> {
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
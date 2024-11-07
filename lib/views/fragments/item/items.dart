// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/item/item_data/item_title.dart';
import 'package:rims_ccs_v1/views/fragments/item/item_data/items_data.dart';

class Items extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Itemtitle(),
        ItemsData('0', 'Capnut', '5'),
        ItemsData('1', 'Caterpillar', '4'),
        ItemsData('2', 'Bolts', '51'),
        ItemsData('3', 'Nuts', '60'),
        ItemsData('4', 'Screw', '1'),
        ItemsData('5', 'Brembo', '2'),
        ItemsData('6', 'AC Motor', '2'),
        ItemsData('7', 'DC Motor', '2'),
        ItemsData('8', 'JRP Shock', '2'),
      ],
    );
  }
}
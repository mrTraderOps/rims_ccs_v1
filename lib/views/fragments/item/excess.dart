// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/item/item_data/item_title.dart';
import 'package:rims_ccs_v1/views/fragments/item/item_data/items_data.dart';

class Excess extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Itemtitle(),
        ItemsData('0', 'Capnut', '5'),
        ItemsData('1', 'Caterpillar', '4'),
      ],
    );
  }
}
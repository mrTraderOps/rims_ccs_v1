// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'RIMS_logo.dart';
import '../../styles.dart';

class RIMSLogoTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RimsLogo(),
        SizedBox(height: 20),
        Text('RIMS - CCS', style: Ui_fonts.TitleTextBoldBlack,),
        Text('Robotics Inventory Management System', style: Ui_fonts.SmallTitleTextBoldBlack)
      ],
    ); 
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/box_group_section.dart';
import 'package:rims_ccs_v1/views/fragments/box/box_status.dart';
import 'box_num.dart';

class BoxData extends StatefulWidget {
  final List<dynamic> data;
  final String title;

  BoxData({
    required this.data,
    required this.title
    });

  @override
  State<BoxData> createState() => _BoxDataState();
}

class _BoxDataState extends State<BoxData> {

 String get _title => widget.title;

  @override
  Widget build(BuildContext context) {
    // Ensure data list has enough items to avoid index errors
    final boxNum = widget.data.isNotEmpty ? widget.data[0] : '';
    final status = widget.data.isNotEmpty ? widget.data[1] : '';
    final section = widget.data.isNotEmpty ? widget.data[2] : '';

    

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxNumber(title: _title, boxNum: boxNum,),
          BoxStatus(status),
          BoxGroupSection(section),
        ],
      ),
    );
  }
}

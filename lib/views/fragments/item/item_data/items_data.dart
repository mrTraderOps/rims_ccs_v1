// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import '../../../styles.dart';

class ItemsData extends StatefulWidget{
  
  final String num;
  final String description;
  final String qty;


  ItemsData ({
    required this.num,
    required this.description,
    required this.qty
  });

  @override
  State<ItemsData> createState() => _ItemsDataState();
}

class _ItemsDataState extends State<ItemsData> {
  String get _num => widget.num;
  String get _description => widget.description;
  String get _qty => widget.qty;

  double Boxheight = 70.0;

  @override
  Widget build(BuildContext context) {
    double bodyHeight = 45.0;

    return  Table(
        border: TableBorder.all(color: Ui_Colors.black),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
            0: FixedColumnWidth(60.0),  // "NO." column width
            1: FlexColumnWidth(4),      // "DESCRIPTION" column takes more space
            2: FixedColumnWidth(60.0),  // "QTY" column width
          },
        children: [
          TableRow(
              children: [
                TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: SizedBox(
                  height: bodyHeight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(_num),
                      ),
                  ),
                )
                ),
                TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: SizedBox(
                  height: bodyHeight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(_description),
                      ),
                  ),
                 )
                ),
                TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: SizedBox(
                  height: bodyHeight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(_qty),
                      ),
                  ),
                )
                ),
              ]
            )
        ],
      );
  }
}
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/box_data.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showDeleteBoxDialog.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Box extends StatefulWidget{
  final List<dynamic> boxData;
  final Function (int) onSelectedBox;
  final String title, boxNum, docId;
  final VoidCallback onDeleteRefresh;

  Box({
    required this.onSelectedBox, 
    required this.boxData,
    required this.title,
    required this.onDeleteRefresh,
    required this.boxNum,
    required this.docId,
    });
  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {

  Function get _onSelectedBox => widget.onSelectedBox;
  List<dynamic> get _boxData => widget.boxData;
  String get _title => widget.title;
  String get _boxNum => widget.boxNum;
  String get _docId => widget.docId;
  VoidCallback get _onDeleteRefresh => widget.onDeleteRefresh;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onSelectedBox(4),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: Container(
          width: 350,
          height: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Ui_Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7), // Shadow color with opacity
                spreadRadius: 3, // Spread radius
                blurRadius: 3, // Blur radius
                offset: Offset(0, 2), // Offset in x and y direction
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 135,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Ui_Colors.white,
                      ),
                      child: Image.asset('assets/images/boxes/box1.png', fit: BoxFit.contain),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: 135,
                        width: 160,
                        child: BoxData(title: _title, data: _boxData),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5, // Adjust positioning as needed
                right: 0, // Adjust positioning as needed
                child: TextButton(
                  onPressed: () => showDeleteBoxDialog(context, 
                  _docId, 
                  _title, 
                  _boxNum,
                  _onDeleteRefresh
                  ),
                  child: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('assets/images/delete_icon.png')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }
  }
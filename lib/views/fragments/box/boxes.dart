// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/box/boxes_list.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/add/showAddBoxDialog.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Boxes extends StatefulWidget {

  final Function(int) onSelectBox;
  final Function(String) onGetBoxNum;
  final String title, headerTitle, groupNumStr, role;

  Boxes({
    Key? key, 
    required this.onSelectBox,
    required this.onGetBoxNum,  
    required this.title,
    required this.headerTitle,
    required this.groupNumStr,
    required this.role,
    }) : super(key: key);

  @override
  State<Boxes> createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {

  Function(int) get _onSelectBox => widget.onSelectBox;

  final SelectedBoxServiceCrud _selectedBoxServiceCrud = SelectedBoxServiceCrud();
  Future<List<List<dynamic>>>? _boxFuture;
  Function (String) get _onGetBoxNum => widget.onGetBoxNum; 
  String get _title => widget.title;
  String get _headerTitle => widget.headerTitle;
  String get _groupNumStr => widget.groupNumStr;
  String get _role => widget.role;

  bool isAdmin = true;

 @override
  void initState() {
  super.initState();

    // Determine if the user is an admin
    _checkIfAdmin();

    // Fetch data for boxes
    _boxFuture = _selectedBoxServiceCrud.fetchDocumentValues('inventory', _groupNumStr);
  }

  void _checkIfAdmin() {
    setState(() {
      isAdmin = _role == 'Admin';
    });
}

  @override
  Widget build(BuildContext context) {

    final robotBoxes1 = RobotBoxesStyles(0.9);
    final robotBoxes2 = RobotBoxesStyles(1.1);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Container(
                height: 150,
                width: 350,
                decoration: BoxDecoration(
                  color: Color(0xFFFFBC2F),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ROBOT',
                      style: robotBoxes1.robotBoxesStyle,
                    ),
                    Text(
                      '$_headerTitle',
                      style: robotBoxes2.robotBoxesStyle,
                    ),
                  ],
                )),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30)),
                    color: Ui_Colors.white,
                  ),
                  child: BoxesList(
                    role: _role,
                    isAdmin: isAdmin,
                    title: _title,
                    onSelectBox: _onSelectBox,
                    onGetBoxNum: _onGetBoxNum, 
                    boxesFuture: _boxFuture,
                    onDeleteRefresh: () {
                      setState(() {
                        _boxFuture = _selectedBoxServiceCrud.fetchDocumentValues('inventory', _groupNumStr);
                      });
                    },
                  ),
                ),
              )   
            ),
          Visibility(
            visible: isAdmin,
            child: Positioned(
              child: Container(
                width: double.infinity,
                color: Ui_Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Ui_Colors.darkBlue,
                    ),
                    onPressed: () => showAddBoxDialog(context, _title, _groupNumStr, () {
                    setState(() {
                      // Refresh the user list by fetching it again
                      _boxFuture = _selectedBoxServiceCrud.fetchDocumentValues('inventory', _groupNumStr);
                      });
                    }),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Ui_Colors.white,
                        ),
                        SizedBox(width: 5), 
                        Text(
                          'Add New $_title',
                          style: TextStyle(
                            color: Ui_Colors.white,
                            fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              )
              ),
          )
        ],
      ),
    );
  }
}
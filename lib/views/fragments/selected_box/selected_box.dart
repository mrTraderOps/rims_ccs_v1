// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/box_dataNav.dart';
import 'package:rims_ccs_v1/views/fragments/item/excess.dart';
import 'package:rims_ccs_v1/views/fragments/inventory/inventory_check.dart';
import 'package:rims_ccs_v1/views/fragments/item/missing.dart';
import '../../styles.dart';
import '../item/items.dart';
import '../item/records.dart';
import 'titlebox_groupName.dart';

class SelectedBox extends StatefulWidget {
  final String boxNumStr, groupNumStr, title, titleContainer;

  SelectedBox({
    Key? key, 
    required this.boxNumStr,
    required this.groupNumStr,
    required this.title,
    required this.titleContainer
  }): super(key: key);
  @override
  State<SelectedBox> createState() => _SelectedBoxState();
}

class _SelectedBoxState extends State<SelectedBox> {

  String get _boxNumStr => widget.boxNumStr;
  String get _titleContainer => widget.titleContainer;  
  String get _groupNumStr => widget.groupNumStr ;
  String get _title => widget.title;

  int _selectedPage = 0;
  bool _isPageOne = true;

  void _navigateToPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleboxGroupname(
          title: _title,
          boxNumStr: _boxNumStr,
          groupNumStr: _groupNumStr,
        ),
        Expanded(
          flex: 6,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Ui_Colors.white,
            child: _isPageOne
                ? Column(
                    children: [
                      Container(
                        height: 50,
                        color: Ui_Colors.darkBlue,
                        child: Row(
                          children: [
                            BoxDataNav(
                              'PARTS',
                              onTap: () => _navigateToPage(0),
                              isActive: _selectedPage == 0,
                            ),
                            BoxDataNav(
                              'MISSING',
                              onTap: () => _navigateToPage(1),
                              isActive: _selectedPage == 1,
                            ),
                            BoxDataNav(
                              'EXCESS',
                              onTap: () => _navigateToPage(2),
                              isActive: _selectedPage == 2,
                            ),
                            BoxDataNav(
                              'RECORDS',
                              onTap: () => _navigateToPage(3),
                              isActive: _selectedPage == 3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: IndexedStack(
                            index: _selectedPage,
                            children: [
                              Items(moduleNum: _boxNumStr,),
                              Missing(titleContainer: _titleContainer, boxNumStr: _boxNumStr, groupNumStr: _groupNumStr,),
                              Excess(titleContainer: _titleContainer, boxNumStr: _boxNumStr, groupNumStr: _groupNumStr,),
                              Records(titleContainer: _titleContainer, boxNumStr: _boxNumStr, groupNumStr: _groupNumStr,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        height: 50,
                        color: Ui_Colors.darkBlue,
                        child: Center(
                          child: Text(
                            'PARTS LIST',
                            style: TextStyle(color: Ui_Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            InventoryCheck()
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Expanded(
          child: Container(
            color: Ui_Colors.lightBlue,
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                     setState(() {
                      _isPageOne = !_isPageOne;
                    });
                  },
                  // onPressed: () async { await _serviceCrud.insertModuleParts();
                  // },
                  child: Container(
                    width: 150,
                    color: Ui_Colors.skyBlue,
                    child: Center(
                      child: Text(
                        _isPageOne ? 'INVENTORY CHECK' : 'CANCEL',
                        style: TextStyle(color: Ui_Colors.darkBlue),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isPageOne,
                  child: TextButton(
                    onPressed: () {
                      //SAVEEE
                    },
                    child: Container(
                      width: 150,
                      color: Ui_Colors.skyBlue,
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(color: Ui_Colors.darkBlue),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

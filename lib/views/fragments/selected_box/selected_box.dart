// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/box_dataNav.dart';
import 'package:rims_ccs_v1/views/fragments/item/excess.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/inventory_check.dart';
import 'package:rims_ccs_v1/views/fragments/item/missing.dart';
import '../../styles.dart';
import '../item/items.dart';
import 'records.dart';
import 'titlebox_groupName.dart';

class SelectedBox extends StatefulWidget {
  @override
  State<SelectedBox> createState() => _SelectedBoxState();
}

class _SelectedBoxState extends State<SelectedBox> {
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
        TitleboxGroupname(),
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
                              'ITEMS',
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
                        child: ListView(
                          children: [
                            if (_selectedPage == 0) Items(),
                            if (_selectedPage == 1) Missing(),
                            if (_selectedPage == 2) Excess(),
                            if (_selectedPage == 3) Records(),
                          ],
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
                            'ITEMS LIST',
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
                    onPressed: () {},
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

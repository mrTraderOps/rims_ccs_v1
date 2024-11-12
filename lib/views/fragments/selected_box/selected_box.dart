// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/inventory_check_service.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showInventorySaveDialog.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/box_dataNav.dart';
import 'package:rims_ccs_v1/views/fragments/item/excess.dart';
import 'package:rims_ccs_v1/views/fragments/inventory/inventory_check.dart';
import 'package:rims_ccs_v1/views/fragments/item/missing.dart';
import '../../styles.dart';
import '../item/items.dart';
import '../item/records.dart';
import 'titlebox_groupName.dart';

class SelectedBox extends StatefulWidget {
  final String boxNumStr, groupNumStr, titleContainer, loginName;

  SelectedBox({
    Key? key, 
    required this.loginName,
    required this.boxNumStr,
    required this.groupNumStr,
    required this.titleContainer,
  }): super(key: key);
  @override
  State<SelectedBox> createState() => _SelectedBoxState();
}

class _SelectedBoxState extends State<SelectedBox> {

  final InventoryCheckService _inventoryCheckService = InventoryCheckService();

  String get _boxNumStr => widget.boxNumStr;
  String get _titleContainer => widget.titleContainer;  
  String get _groupNumStr => widget.groupNumStr;
  String get _loginName => widget.loginName;


  List<Map<String, dynamic>> _itemData = [];
  Map<String, int> _inputQtyMap = {};

  int _selectedPage = 0;
  bool _isPageOne = true;

  void _navigateToPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void getData (List<Map<String, dynamic>> itemData, Map<String, int> inputQtymap, ) {
    setState(() {
      _itemData = itemData;
      _inputQtyMap = inputQtymap;
    });

    // Display data in console
    for (var row in itemData) {
      print(row);
      }
    _inputQtyMap.forEach((num, qty) {
      print('num: $num, qty: $qty');
    });
  }

  void onCheckandSaveInventory() async {
  String doc = '${_titleContainer.toLowerCase()}$_boxNumStr';
  String docId = 'group$_groupNumStr-$doc';
  String remarks = 'COMPLETE';
  List<String> missingItems = [];

  for (var row in _itemData) {
    String num = row['num'].toString();
    if (!_inputQtyMap.containsKey(num) || _inputQtyMap[num] == null) {
      missingItems.add(row['_itemName']);
    }
  }

  if (missingItems.isNotEmpty) {
    String _missingItems = missingItems.join(", ");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in the inputs for: $_missingItems')),
    );
    return;
  }

  bool hasAnyChanges = false;

  for (var entry in _inputQtyMap.entries) {
    String num = entry.key;
    int inputQty = entry.value;

    var item = _itemData.firstWhere(
      (row) => row['num'].toString() == num,
      orElse: () => {},
    );

    if (item.isNotEmpty) {
      int originalQty = item['qty'];
      String itemName = item['_itemName'];

      bool changes = await _inventoryCheckService.checkAndSaveInventory(
        originalQty,
        inputQty,
        num,
        itemName,
        _groupNumStr,
        _titleContainer.toLowerCase(),
        _boxNumStr,
        _loginName,
      );
      

      if (changes) {
        hasAnyChanges = true;
      }
    }
  }

  if (hasAnyChanges) {

    await _inventoryCheckService.statusBoxModule(docId);

  } else if (!hasAnyChanges) {
    
    // Record as Complete the Module or Box
    await _inventoryCheckService.recordData(docId, _loginName, _groupNumStr, remarks);

    // No missing or excess data - call deleteData
    await _inventoryCheckService.deleteInventoryData(
      _groupNumStr,
      _titleContainer.toLowerCase(),
      _boxNumStr,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All items are complete. Missing/Excess data cleared.')),
    );

    // Re-scan the Documents to declare as completed Module or Box
    await _inventoryCheckService.statusBoxModule(docId);

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Your Inventory is Successfully Saved!')),
    );
  }

  onPageOne(_isPageOne);
}

  void onPageOne(bool pageOne) {
    setState(() {
      _isPageOne = !_isPageOne;
    });
    if (_isPageOne) {
      _inputQtyMap.clear();
      _itemData.clear();
      print('Data cleared: _inputQtyMap and _itemData reset');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleboxGroupname(
          title: _titleContainer.toUpperCase(),
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
                        child: SingleChildScrollView(
                          scrollDirection:  Axis.vertical,
                          child: InventoryCheck(
                            moduleNum: _boxNumStr,
                            getData: getData ,
                            inputQtyMap: _inputQtyMap,
                            )                         
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
                  onPressed: () => onPageOne(_isPageOne),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Ui_Colors.skyBlue,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    width: 150,
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
                    onPressed: () async {
                        showInventorySaveDialog(context, onCheckandSaveInventory, _titleContainer, _boxNumStr);
                    },  
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Ui_Colors.skyBlue,
                        borderRadius: BorderRadius.circular(5)
                      ),
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

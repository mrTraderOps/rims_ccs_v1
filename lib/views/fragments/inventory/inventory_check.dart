// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';
import 'items_input.dart';

class InventoryCheck extends StatefulWidget {
  final String moduleNum;
  final Map<String, int> inputQtyMap;
  final Function(
    List<Map<String, dynamic>>,
    Map<String, int>
  ) getData;

  InventoryCheck({
    required this.moduleNum,
    required this.getData,
    required this.inputQtyMap,
  });

  @override
  State<InventoryCheck> createState() => _InventoryCheckState();
}

class _InventoryCheckState extends State<InventoryCheck> {

  Function(
    List<Map<String, dynamic>>,
    Map<String, int>
  ) get _getData => widget.getData;

  final double headerHeight = 70.0;
  final double bodyHeight = 70.0;

  Map<String, int> get _inputQtyMap => widget.inputQtyMap;

  String get _moduleNum => widget.moduleNum;

  final SelectedBoxServiceCrud _service = SelectedBoxServiceCrud();
  late Future<List<Map<String, dynamic>>> _fetchModule;

  @override
  void initState() {
    super.initState();
    _fetchModule = _service.fetchModuleParts(_moduleNum);
  }

  void _loadData() {
    setState(() {
      _fetchModule = _service.fetchModuleParts(_moduleNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchModule,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available. Contact your dev.'));
        }

        final itemData = snapshot.data!;

        return Table(
          border: TableBorder.all(color: Ui_Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(4),  // "DESCRIPTION" column width
            1: FixedColumnWidth(60),  // "QTY" column width
            2: FixedColumnWidth(70.0),  // "INPUT" column width
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Ui_Colors.yellow),
              children: [
                _buildTableHeaderCell('DESCRIPTION'),
                _buildTableHeaderCell('QTY'),
                _buildTableHeaderCell('INPUT'),
              ],
            ),
            ...itemData.map((row) {
             
              int originalQty = row['qty'];
              String description = row['_itemName'];
              String num = row['num'].toString();

              return TableRow(
                children: [
                  TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: SizedBox(
                            height: bodyHeight,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(description),
                              ),
                            ),
                          ),
                        ),
                  TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: SizedBox(
                          height: bodyHeight,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('x'+originalQty.toString()),
                            ),
                          ),
                        ),
                      ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: bodyHeight,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ItemsInput(
                              num: num,
                              onInputChanged: (num, qty) {
                                setState(() {
                                  _inputQtyMap[num] = qty;
                                });
                                _getData(itemData, _inputQtyMap);
                              },
                            ),
                          ),
                        ),
                      )
                    )
                ],
              );
            }).toList(),
          ],
        );
      },
    );
  }

  TableCell _buildTableHeaderCell(String title) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: headerHeight,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ),
      ),
    );
  }

  TableCell _buildTableBodyCell(Widget child) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: bodyHeight,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

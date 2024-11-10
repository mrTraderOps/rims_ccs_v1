// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Items extends StatefulWidget{

  final String moduleNum;

  Items({
    required this.moduleNum
  });

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {

  String get _moduleNum => widget.moduleNum;

  final SelectedBoxServiceCrud _service = SelectedBoxServiceCrud();
  late Future<List<Map<String, dynamic>>> _fetchModule;

  @override
  void initState() {
    super.initState();
    // Initial load of data
    _fetchModule = _service.fetchModuleParts(_moduleNum);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refetch the data when navigating to this widget
    _loadData();
  }

  void _loadData() {
    setState(() {
      _fetchModule = _service.fetchModuleParts(_moduleNum);
    });
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = 55.0;
    double bodyHeight = 50.0;

    return FutureBuilder(
      future: _fetchModule,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('NO DATA AVAILABLE CONTACT YOUR DEV EARL VERZON'));
        }

        final itemData = snapshot.data!;

        return Table(
          border: TableBorder.all(color: Ui_Colors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FixedColumnWidth(60.0),  // "NO." column width
            1: FlexColumnWidth(4),      // "DESCRIPTION" column takes more space
            2: FixedColumnWidth(60.0),  // "QTY" column width
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Ui_Colors.yellow),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: headerHeight,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('NO.'),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: headerHeight,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('DESCRIPTION'),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: headerHeight,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('QTY'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ...itemData.map((row) {

              String _qty = row['qty'].toString();
              String _num = row['num'].toString();
              String _description = row['_itemName'].toString();

              return TableRow(
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
                    ),
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
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: bodyHeight,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('x'+_qty),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

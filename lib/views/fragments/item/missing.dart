// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Missing extends StatefulWidget{

  final String titleContainer, groupNumStr, boxNumStr;

  Missing({
    required this.titleContainer,
    required this.boxNumStr,
    required this.groupNumStr,
    });

  @override
  State<Missing> createState() => _MissingState();
}

class _MissingState extends State<Missing> {
  
  String get _titleContainer => widget.titleContainer.toLowerCase();
  String get _groupNumStr => widget.groupNumStr;
  String get _boxNumStr => widget.boxNumStr;

  String get docId => _titleContainer + _boxNumStr; 

  String get collectionPath => '/inventory/group$_groupNumStr-$docId/missing';

  final SelectedBoxServiceCrud _service = SelectedBoxServiceCrud();
  late Future<List<List<dynamic>>> _tableData;

  
  @override
  void initState() {
    super.initState();
    _tableData = _service.fetchItemData(collectionPath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refetch the data when navigating to this widget
    _loadData();
  }

  void _loadData() {
    setState(() {
      _tableData = _service.fetchItemData(collectionPath);
    });
  }


  @override
  Widget build(BuildContext context) {

    double headerHeight = 55.0;
    double bodyHeight = 45.0;

    return FutureBuilder(
      future: _tableData, 
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  'Congrats! This $_titleContainer is COMPLETE!',
                  style: TextStyle(
                    fontFamily: 'Mina',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)),
            );
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
                  decoration: BoxDecoration(
                  color: Ui_Colors.yellow
                ),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: headerHeight,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(' NO.'),
                          ),
                      ),
                    )
                    ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: SizedBox(
                      height: headerHeight,
                      child: Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('DESCRIPTION'),
                            ),
                        ),
                      ),
                    )
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
                    )
                  ),
                ]
              ),
              ...itemData.map((row) {
                return TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: SizedBox(
                        height: bodyHeight,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(row[0]),
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
                            child: Text(
                              row[1],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 42, 0)
                                ),
                              ),
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
                            child: Text(
                              row[2],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 42, 0)
                                ),
                              ),
                            ),
                        ),
                      )
                    ),
                  ],
                );
              }).toList()
            ],
          );
    });
  }
}
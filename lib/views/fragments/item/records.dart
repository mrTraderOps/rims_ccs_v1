// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/selected_box_service_CRUD.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class Records extends StatefulWidget {

  final String titleContainer, groupNumStr, boxNumStr;

  Records({
    required this.titleContainer,
    required this.boxNumStr,
    required this.groupNumStr,
    });

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {

  String get _titleContainer => widget.titleContainer.toLowerCase();
  String get _groupNumStr => widget.groupNumStr;
  String get _boxNumStr => widget.boxNumStr;

  String get docId => _titleContainer + _boxNumStr; 

  String get collectionPath => '/inventory/group$_groupNumStr-$docId/records';

  final SelectedBoxServiceCrud _service = SelectedBoxServiceCrud();
  late Future<List<List<dynamic>>> _tableData;


  @override
  void initState() {
    super.initState();
    _tableData = _service.fetchRecordData(collectionPath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _tableData = _service.fetchRecordData(collectionPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tableData, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(child: CircularProgressIndicator()),
          );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text(
                  'This $_titleContainer has no records yet',
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
                0: FixedColumnWidth(90.0), 
                1: FixedColumnWidth(80.0),      
                2: FixedColumnWidth(100.0),
                3: FlexColumnWidth(2.0),  
              },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Ui_Colors.yellow
                ),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('DATE'),
                      )
                    ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('SECTION'),
                      )
                    ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('GROUP NO.'),
                      )
                    ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('REMARKS'),
                      )
                    )
                ]
              ),
              ...itemData.map((row) {
                 Color _color;

                switch (row[3].toString()) {
                  case 'COMPLETE':
                    _color = const Color.fromARGB(255, 0, 188, 6);
                    break;
                  case 'EXCESS':
                    _color = const Color.fromARGB(255, 216, 108, 0);
                    break;
                  case 'MISSING':
                    _color = const Color.fromARGB(255, 206, 3, 0);
                    break;
                  default:
                    _color = Colors.black; // Fallback color for unexpected cases
                }


                return TableRow(
                  children: [
                    TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(row[0].toString()),
                      )
                    ),
                    TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(row[1].toString())),
                      )
                    ),
                    TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(row[2].toString())),
                      )
                    ),
                    TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        row[3].toString(),
                        style: TextStyle(
                          color: _color,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      )
                    ),
                  ]
                );
              }).toList(),
            ],
          );   
      }
    );
  }
}




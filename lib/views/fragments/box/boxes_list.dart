// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/box.dart';

class BoxesList extends StatefulWidget {

  final Function(int) onSelectBox;
  final Function(String) onGetBoxNum;
  final Future<List<List<dynamic>>>? boxesFuture;
  final String title, role;
  final VoidCallback onDeleteRefresh;
  final bool isAdmin;

  BoxesList({
    required this.onSelectBox,
    required this.onGetBoxNum, 
    required this.boxesFuture,
    required this.title,
    required this.role,
    required this.onDeleteRefresh,
    required this.isAdmin
    });

  @override
  State<BoxesList> createState() => _robotBoxesListState();
}

class _robotBoxesListState extends State<BoxesList> {
  
  String get _title => widget.title;
  String get _role => widget.role;
  VoidCallback get _onDeleteRefresh => widget.onDeleteRefresh;
  Function (String) get _onGetBoxNum => widget.onGetBoxNum;
  Function (int) get _onSelectBox => widget.onSelectBox;

  bool get _isAdmin => widget.isAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FutureBuilder<List<List<dynamic>>>(
        future: widget.boxesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No boxes found'));
          }

          final boxesList = snapshot.data!;

          return ListView.builder(
            itemCount: boxesList.length,
            itemBuilder: (context, index) {
              final boxData = boxesList[index];
              final _docId = boxData[3].toString();
              final _boxNum = boxData[0].toString();

              return Box(
                role: _role,
                isAdmin: _isAdmin,
                docId: _docId,
                boxNum: _boxNum,
                onDeleteRefresh: _onDeleteRefresh,
                title: _title,
                onSelectedBox: (selectedIndex) {
                  // Call _onGetBoxNum only when a specific box is selected
                  _onGetBoxNum(_boxNum);
                  _onSelectBox(selectedIndex);
                },
                boxData: boxData,
              );
            },
          );
        },
      ),
    );
  }
}
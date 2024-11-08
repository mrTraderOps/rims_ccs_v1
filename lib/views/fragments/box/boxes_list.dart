// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/box.dart';

class BoxesList extends StatefulWidget {

  final Function(int) onSelectBox;
  final Future<List<List<dynamic>>>? boxesFuture;
  final String title;
  final VoidCallback onDeleteRefresh;

  BoxesList({
    required this.onSelectBox, 
    required this.boxesFuture,
    required this.title,
    required this.onDeleteRefresh,
    });

  @override
  State<BoxesList> createState() => _robotBoxesListState();
}

class _robotBoxesListState extends State<BoxesList> {
  
  String get _title => widget.title;
  VoidCallback get _onDeleteRefresh => widget.onDeleteRefresh;

  int onSelect = 0;

  void _onSelectedBox(int index) {
    setState(() {
      onSelect = index;
    });
    widget.onSelectBox(onSelect);
  }

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
              final _docId = boxData[0].toString();
              final _boxNum = boxData[1].toString();

              return Box(
                docId: _docId,
                boxNum: _boxNum,
                onDeleteRefresh: _onDeleteRefresh,
                title: _title,
                onSelectedBox: _onSelectedBox,
                boxData: boxData,
              );
            },
          );
        },
      ),
    );
  }
}
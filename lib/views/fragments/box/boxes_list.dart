// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/box.dart';

class BoxesList extends StatefulWidget {

  final Function(int) onSelectBox;
  final Future<List<List<dynamic>>>? boxesFuture;
  // final String title;

  BoxesList({required this.onSelectBox, required this.boxesFuture});

  @override
  State<BoxesList> createState() => _robotBoxesListState();
}

class _robotBoxesListState extends State<BoxesList> {
  
  Future<List<List<dynamic>>>? get _boxesFuture => widget.boxesFuture;
  // String get _title => widget.title;

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
        future: _boxesFuture,
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

              return Box(
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
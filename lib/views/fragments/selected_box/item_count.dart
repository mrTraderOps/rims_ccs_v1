import 'package:flutter/material.dart';

class ItemCount extends StatelessWidget {

  final String _count;

  ItemCount(this._count);

  @override
  Widget build(BuildContext context) {
    return Center(
       child: Text(_count),
    );
  }
}
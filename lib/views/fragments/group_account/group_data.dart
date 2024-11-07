import 'package:flutter/material.dart';
import 'group_text.dart';

class GroupData extends StatelessWidget {
  final Map<String, String> data;

  GroupData({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        return GroupText(entry.key, entry.value);
      }).toList(),
    );
  }
}

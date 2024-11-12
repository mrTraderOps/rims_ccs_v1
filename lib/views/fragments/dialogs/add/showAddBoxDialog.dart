// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/add/addBox_dialog.dart';

void showAddBoxDialog(BuildContext context, String title,  String groupNum, VoidCallback onAddRefresh) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddBoxDialog(onAddRefresh: onAddRefresh, title: title, groupNumStr: groupNum,);
    },
  );
}

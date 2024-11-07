// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/addBox_dialog.dart';

void showAddBoxDialog(BuildContext context, VoidCallback onAddRefresh) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddBoxDialog(onAddRefresh: onAddRefresh);
    },
  );
}

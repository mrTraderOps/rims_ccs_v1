// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/addUser_dialog.dart';

void showAddUserDialog(BuildContext context, VoidCallback onAddRefresh) {


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddUserDialog(onAddRefresh: onAddRefresh);
    },
  );
}

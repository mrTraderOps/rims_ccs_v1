// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/add/addGroup_dialog%20.dart';

void showAddGroupDialog(BuildContext context, VoidCallback onAddRefresh) {


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddGroupDialog(
        onAddRefresh: onAddRefresh,
        );
    },
  );
}

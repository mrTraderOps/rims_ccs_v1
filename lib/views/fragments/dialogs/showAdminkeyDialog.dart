// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/AdminKeyDialog.dart';

void showAdminKeyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AdminKeyDialog();
    },
  );
}

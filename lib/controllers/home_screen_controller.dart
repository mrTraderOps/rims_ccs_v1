// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/pages/admin_page.dart';
import 'package:rims_ccs_v1/views/pages/group_page.dart';
import 'package:rims_ccs_v1/views/pages/prof_page.dart';

class HomeScreen extends StatelessWidget {
  final String? role, nickname, title, name, suffix, groupNumber, section;

  HomeScreen({
    this.role, 
    this.nickname, 
    this.title, 
    this.name,
    this.suffix,
    this.groupNumber,
    this.section
    });

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case 'Prof':
        return ProfHomepage(
          role: role ?? '',
          nickname: nickname ?? '', 
          title: title ?? '', 
          name: name ?? '',
          suffix: suffix ?? ''
          );
      case 'Group':
        return GroupHomepage(
          role: role ?? '', 
          groupNumber: groupNumber ?? '',
          section: section ?? '',
          title: title ?? '',
          );
      case 'Admin':
        return AdminHomepage(
          role: role ?? '',
          nickname: nickname ?? '', 
          title: title ?? '', 
          name: name ?? '',
          suffix: suffix ?? ''
          );
      default:
        return Scaffold(
          body: Center(child: Text('Unknown role')),
        );
    }
  }
}

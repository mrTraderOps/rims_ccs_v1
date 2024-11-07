// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/pages/admin_page.dart';
import 'package:rims_ccs_v1/views/pages/group_page.dart';
import 'package:rims_ccs_v1/views/pages/prof_page.dart';

class HomeScreen extends StatelessWidget {
  final String role, nickname, title, name, suffix;

  HomeScreen({
    required this.role, 
    required this.nickname, 
    required this.title, 
    required this.name,
    required this.suffix,
    });

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case 'Prof':
        return ProfHomepage(
          role: role,
          nickname: nickname, 
          title: title, 
          name: name,
          suffix: suffix
          );
      case 'Group':
        return GroupHomepage(
          role: role, 
          nickname: nickname, 
          title: title, 
          name: name,
          suffix: suffix
          );
      case 'Admin':
        return AdminHomepage(
          role: role, 
          nickname: nickname, 
          title: title, 
          name: name,
          suffix: suffix
          );
      default:
        return Scaffold(
          body: Center(child: Text('Unknown role')),
        );
    }
  }
}

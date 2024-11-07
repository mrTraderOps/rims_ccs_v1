// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/box/boxes.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/selected_box.dart';
import '../fragments/drawer/drawer.dart';
import '../styles.dart';

class GroupHomepage extends StatefulWidget {

  final String role, nickname, title, name, suffix;

  GroupHomepage({required this.role, required this.nickname, required this.title, required this.name, required this.suffix});

  @override
  State<GroupHomepage> createState() => _GroupHomepageState();
}

class _GroupHomepageState extends State<GroupHomepage> {

  final robotBoxes1 = RobotBoxesStyles(0.9);

  final robotBoxes2 = RobotBoxesStyles(1.1);

  int _selectedIndex = 0;
  String AppBarTitle = '';
  bool isActive = false;
  String get _role => widget.role;
  String get _nickname => widget.nickname;
  String get _title => widget.title;
  String get _name => widget.name;
  String get _suffix => widget.suffix;

  void _onSelectTab(int index) {
    setState(() {
      _selectedIndex = index;
      isActive = true;
    });
    
    Navigator.pop(context);

    switch (index){
      case 0: AppBarTitle = 'RIMS - CCS'; 
        break;
      case 1: AppBarTitle = 'PROFILE SETTING'; 
        break;
      case 2: AppBarTitle = 'GROUP ACCOUNT'; 
        break;   
    }
  }
  void _onSelectBox(int index) {
    setState(() {
      _selectedIndex = index;
      isActive = true;
    });

    switch (index){
      case 3: AppBarTitle = 'BOX INFO'; 
        break;    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 176, 135, 38),
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Ui_Colors.darkBlue,
        title: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            isActive ? AppBarTitle : 'RIMS - CCS',
            style: TextStyle(
              fontFamily: 'Mina',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Ui_Colors.white
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Ui_Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 47, 47, 47).withOpacity(0.8), // Shadow color with opacity
                  spreadRadius: 0, // How much the shadow should spread
                  blurRadius: 6,  // How blurred the shadow should be
                  offset: Offset(2, 5), // Horizontal and vertical offset of the shadow              
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/mini_bot.png',
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ), 
      drawer: Drawer(
        backgroundColor: Ui_Colors.darkBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Ui_Colors.white
                    ),
                    child: Center(
                       child: Container(
                        width: 110,
                        height: 110,
                        child: Image.asset('assets/images/mini_bot.png', fit: BoxFit.contain),
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '$_role $_nickname',
                      style: TextStyle(
                        fontFamily: 'Mina',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Ui_Colors.white
                      ),
                    ),
                    ),
                  Text(
                    '$_title',
                     style: TextStyle(
                        fontFamily: 'Mina',
                        fontSize: 12,
                        color: Ui_Colors.white
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: DrawerFragment(onSelectTab: _onSelectTab, role: _role,),
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Boxes(
          //   key: ValueKey(_selectedIndex),
          //   onSelectBox: _onSelectBox),
          SelectedBox()
        ],
      )
    );
  }
}

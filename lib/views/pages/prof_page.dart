// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/views/fragments/account_setting/account_setting.dart';
import 'package:rims_ccs_v1/views/fragments/box/boxes.dart';
import 'package:rims_ccs_v1/views/fragments/feedback/feedback.dart';
import 'package:rims_ccs_v1/views/fragments/group_account/group_account.dart';
import 'package:rims_ccs_v1/views/fragments/groups/Groups.dart';
import 'package:rims_ccs_v1/views/fragments/selected_box/selected_box.dart';
import '../fragments/drawer/drawer.dart';
import '../styles.dart';

class ProfHomepage extends StatefulWidget {
  final String role, nickname, title, name, suffix;

  ProfHomepage({required this.role,
      required this.nickname,
      required this.title,
      required this.name,
      required this.suffix});

  @override
  State<ProfHomepage> createState() => _ProfHomepageState();
}

class _ProfHomepageState extends State<ProfHomepage> {

  int _selectedIndex = 0;
  String AppBarTitle = '';
  String titleContainer = '';
  String headerTitle = '';
  String newNickname = '';
  String boxNumStr = '';
  String groupNumStr = '';

  bool isActive = false;
  bool isFeedback = false;
  String get _role => widget.role;
  String get _title => widget.title;
  String get _name => widget.name;
  String get _suffix => widget.suffix;
  String get _nickname => widget.nickname;

  @override
  void initState () {
    super.initState();
    newNickname = _nickname;
  }

  void _onSelectTab(int index) {
    setState(() {
      _selectedIndex = index;
      isActive = true;
      isFeedback = false;
    });

    if (index <= 3) {
      Navigator.pop(context);

      switch (index) {
        case 0:
          AppBarTitle = 'ROBOTRACK';
          break;
        case 1:
          AppBarTitle = 'PROFILE SETTING';
          break;
        case 2:
          AppBarTitle = 'GROUP ACCOUNT';
          break;
        case 3:
          setState(() {
             isFeedback = true;
          });
          AppBarTitle = 'CONCERNS & FEEDBACK';
          break;
      }
    } 
  }

  void _onSelectGroup(int index, int groupNum) {
    setState(() {
      _selectedIndex = index;
      isActive = true;
    });

    groupNumStr = groupNum.toString();

    if (groupNum < 5) {
      switch (index) {
      case 4:
        AppBarTitle = 'GROUP $groupNum - MODULES';
        titleContainer = 'Module';
        headerTitle = 'MODULES';
        break;
      }
    } else {
      switch (index) {
      case 4:
        AppBarTitle = 'GROUP $groupNum - BOXES';
        titleContainer = 'Box';
        headerTitle = 'BOXES';
        break;
      }
    }
  }

  void _onSelectBox(int index) {
    setState(() {
      _selectedIndex = index;
      isActive = true;
    });

    switch (index) {
      case 5:
        AppBarTitle = 'BOX INFO';
        break;
    }
  }

  void _onGetBoxNum(String boxNum) {
    setState(() {
      boxNumStr = boxNum;
    });
  }

  void _onChangeNickname(String nickname) {
    setState(() {
      newNickname = nickname;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFeedback ? Ui_Colors.skyBlue : const Color.fromARGB(255, 176, 135, 38),
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Ui_Colors.darkBlue,
        title: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            isActive ? AppBarTitle : 'ROBOTRACK',
            style: TextStyle(
                fontFamily: 'Mina',
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Ui_Colors.white),
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
                  color: const Color.fromARGB(255, 47, 47, 47)
                      .withOpacity(0.8), // Shadow color with opacity
                  spreadRadius: 0, // How much the shadow should spread
                  blurRadius: 6, // How blurred the shadow should be
                  offset: Offset(2, 5), // Horizontal and vertical offset
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
                          shape: BoxShape.circle, color: Ui_Colors.white),
                      child: Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.asset('assets/images/mini_bot.png',
                              fit: BoxFit.contain),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '$_role $newNickname',
                      style: TextStyle(
                          fontFamily: 'Mina',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Ui_Colors.white),
                    ),
                  ),
                  Text(
                    '$_title',
                    style: TextStyle(
                        fontFamily: 'Mina', fontSize: 12, color: Ui_Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: DrawerFragment(
                onSelectTab: _onSelectTab,
                role: _role,
              ),
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Groups(
            onSelectGroup: _onSelectGroup,
          ),
          AccountSetting(
            key: ValueKey(_selectedIndex),
            name: _name,
            title: _title,
            suffix: _suffix,
            updateNickname: _onChangeNickname,
          ),
          GroupAccount(
            role: _role,
            key: ValueKey(_selectedIndex),
            buttonTitle: 'Group',
          ),
          FeedbackPage(),
          Boxes(
            role: _role,
            groupNumStr: groupNumStr,
            onGetBoxNum: _onGetBoxNum,
            key: ValueKey(_selectedIndex),
            headerTitle: headerTitle,
            title: titleContainer,
            onSelectBox: _onSelectBox),
          SelectedBox(
            loginName: _role,
            key: ValueKey(_selectedIndex),
            titleContainer: titleContainer,
            groupNumStr: groupNumStr,
            boxNumStr: boxNumStr
          )
        ],
      ),
    );
  }
}

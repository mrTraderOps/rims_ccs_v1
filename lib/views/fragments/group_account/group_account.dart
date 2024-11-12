// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/add/showAddGroupDialog.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/delete/showDeleteUserDialog.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/add/showAddUserDialog.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/update/showUpdateGroup.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/update/showUpdateUser.dart';
import 'group_container.dart';
import '../../styles.dart';

class GroupAccount extends StatefulWidget {
  final String buttonTitle, role;

  GroupAccount({Key? key, required this.buttonTitle, required this.role}) : super(key: key);


  @override
  State<GroupAccount> createState() => _GroupAccountState();
}

class _GroupAccountState extends State<GroupAccount> {

  final FirestoreService _firestoreService = FirestoreService();
  Future<List<Map<String, dynamic>>>? _usersFuture;
  String get _role => widget.role;

  @override
  void initState() {
    super.initState();
    _usersFuture = _firestoreService.fetchDocuments('users', _role);
  }

  void onCheckRoleAdd (String role) {
    if (role == 'Admin') {
      showAddUserDialog(context, () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    } else if (role == 'Prof') {
      showAddGroupDialog(context, () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    }
  }

  void onCheckRoleUpdate (String role, String documentId) {
    if (role == 'Admin') {
      showUpdateUserDialog(context, documentId, () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    } else if (role == 'Prof') {
      showUpdateGroupDialog(context, documentId , () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    }
  }

  void onCheckRoleDelete (String role, String documentId, nickname) {
    if (role == 'Admin') {
      showUpdateUserDialog(context, documentId, () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    } else if (role == 'Prof') {
      showUpdateGroupDialog(context, documentId , () {
        setState(() {
          // Refresh the user list by fetching it again
          _usersFuture = _firestoreService.fetchDocuments('users', _role);
          });
        } 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Ui_Colors.skyBlue,
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No users found'));
                }

                final users = snapshot.data!;

                return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final userData = user.map((key, value) => MapEntry(key, value.toString()));
                    final documentId = user['id'];
                    dynamic nickname, groupNum, section;


                    if (_role == 'Admin') {
                      nickname = user['Nickname'];
                    } else if (_role == 'Prof') {
                      groupNum = user['Group Number'];
                      section = user['Section'];
                      nickname = 'Group $groupNum - $section';
                    }
                    
                    return GroupContainer(
                      userData: userData,
                      onDeleteRefresh: () => showDeleteAccountDialog(context, documentId, nickname , () {
                        setState(() {
                          // Refresh the user list by fetching it again
                          _usersFuture = _firestoreService.fetchDocuments('users', _role);
                        });
                      }),
                      onUpdateRefresh: () => onCheckRoleUpdate(_role, documentId)
                    );
                  },
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () => onCheckRoleAdd(_role),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Ui_Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  "Add ${widget.buttonTitle} Account",
                  style: TextStyle(
                    fontFamily: 'Mina',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Ui_Colors.white,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Ui_Colors.darkBlue,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ),
      ],
    );
  }

  }

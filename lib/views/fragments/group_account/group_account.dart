// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/models/services/role_account_CRUD.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showDeleteUserDialog.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showAddUserDialog.dart';
import 'package:rims_ccs_v1/views/fragments/dialogs/showUpdateUser.dart';
import 'group_container.dart';
import '../../styles.dart';

class GroupAccount extends StatefulWidget {
  final String buttonTitle;

  GroupAccount({Key? key, required this.buttonTitle}) : super(key: key);


  @override
  State<GroupAccount> createState() => _GroupAccountState();
}

class _GroupAccountState extends State<GroupAccount> {

  final FirestoreService _firestoreService = FirestoreService();
  Future<List<Map<String, dynamic>>>? _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _firestoreService.fetchDocuments('users');
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
                  final nickname = user['nickname'];

                   return GroupContainer(
                    userData: userData,
                    onDeleteRefresh: () => showDeleteAccountDialog(context, documentId, nickname , () {
                      setState(() {
                        // Refresh the user list by fetching it again
                        _usersFuture = _firestoreService.fetchDocuments('users');
                      });
                    }),
                    onUpdateRefresh: () => showUpdateUserDialog(context, documentId, () {
                      setState(() {
                        // Refresh the user list by fetching it again
                        _usersFuture = _firestoreService.fetchDocuments('users');
                      });
                    }), // Pass the documentId
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
          onPressed: () => showAddUserDialog(context, () {
            setState(() {
              // Refresh the user list by fetching it again
              _usersFuture = _firestoreService.fetchDocuments('users');
              });
            } 
          ),
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

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'group_data.dart';
import 'package:rims_ccs_v1/views/styles.dart';

class GroupContainer extends StatelessWidget {
  final Map<String, String> userData;
  final VoidCallback onDeleteRefresh;
  final VoidCallback onUpdateRefresh;
 // Add a callback for deletion

  GroupContainer({required this.userData, required this.onDeleteRefresh, required this.onUpdateRefresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 66, 66, 66).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(30, 30),
                      ),
                      onPressed: () {
                        onUpdateRefresh();
                      },
                      child: Container(
                        width: 30,
                        child: Image.asset(
                          'assets/images/pencil_icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        onDeleteRefresh();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(30, 30),
                      ),
                      child: Container(
                        width: 24,
                        child: Image.asset(
                          'assets/images/delete_icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Ui_Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 130,
                      width: 4,
                    ),
                    SizedBox(width: 15),
                    GroupData(data: userData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

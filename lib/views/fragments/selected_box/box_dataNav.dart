import 'package:flutter/material.dart';
import '../../styles.dart';

class BoxDataNav extends StatelessWidget {
  final String navName;
  final VoidCallback onTap;
  final bool isActive;

  BoxDataNav(this.navName, {required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isActive ? Ui_Colors.lightBlue : Ui_Colors.darkBlue,
          shape: RoundedRectangleBorder(),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            navName,
            style: TextStyle(
              color: isActive ? Ui_Colors.darkBlue : Ui_Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

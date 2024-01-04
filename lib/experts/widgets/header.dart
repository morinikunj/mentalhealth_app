import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String text;
  Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        //color: Colors.black54,
      ),
    );
  }
}

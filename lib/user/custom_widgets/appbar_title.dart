import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final title;
  const AppBarTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}

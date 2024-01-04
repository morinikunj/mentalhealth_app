import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class HeaderText extends StatelessWidget {
  final String label;
  final Color color;
  HeaderText(
      {super.key, required
      this.color,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

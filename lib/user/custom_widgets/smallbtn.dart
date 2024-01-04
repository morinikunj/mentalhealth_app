import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class SmallBtn extends StatelessWidget {
  final String title;
  SmallBtn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 140,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.mentalBrandColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.mentalBrandLightColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

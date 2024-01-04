import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class RoundBtn extends StatelessWidget {
  final String title;
  RoundBtn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.mentalBrandColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          color: AppColors.mentalBrandLightColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

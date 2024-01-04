import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class LoadingBtn extends StatelessWidget {
  LoadingBtn({super.key});

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
      child: Center(
        child:  CircularProgressIndicator(
        
        color: Colors.white,
      ),
      ),
    );
  }
}

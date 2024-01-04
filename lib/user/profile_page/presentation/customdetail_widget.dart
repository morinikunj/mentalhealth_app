import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class DetailWidget extends StatelessWidget {
  final icon;
  final String? label;
  final String? data;
  final space;
  var iconsize;
  DetailWidget(
      {super.key,
      this.icon,
      this.data,
      this.label,
      this.iconsize = 20.0,
      this.space = 40.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 0.5,
            ),
          ],
          border: Border.all(
            color: AppColors.mentalBrandColor,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            size: iconsize,
            color: AppColors.mentalBrandColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            label!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: space,
          ),
          Text(
            data!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class EditProfileWidget extends StatelessWidget {
  final icon;
  final String? label;
  final data;
  final space;
  var iconsize;
  final formkey;
  EditProfileWidget(
      {super.key,
      this.icon,
      this.data,
      this.label,
      this.formkey,
      this.iconsize = 20.0,
      this.space = 40.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
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
          Container(
            width: 200,
            height: 40,
            padding: EdgeInsets.only(top: 5),
            child: TextFormField(
              key: formkey,
              controller: data,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
              ),
            ),
          )
        ],
      ),
    );
  }
}

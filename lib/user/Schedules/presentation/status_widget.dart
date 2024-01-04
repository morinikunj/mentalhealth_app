import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  Function()? onpressed;
  Color? bgcolor;
  Color? txtcolor;
  StatusWidget(
      {super.key,
      required this.title,
      this.onpressed,
      this.bgcolor,
      this.txtcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: txtcolor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

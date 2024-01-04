import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilepageWidget extends StatelessWidget {
  final Color color;
  final String title;
  final icon;
  final Color bgicon;
   Function()? onpressed;

   ProfilepageWidget(
      {super.key,
      required this.color,
      required this.bgicon,
      required this.title,
      required this.icon,
      this.onpressed
      });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpressed!,
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgicon,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}

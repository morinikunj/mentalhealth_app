import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class SessionCard extends StatefulWidget {
  final title;
  final index;
  const SessionCard({super.key, this.index, this.title});

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: EdgeInsets.all(15),
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 1.8,
            spreadRadius: 0.5,
            color: Colors.black12
          )],
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Session ${widget.index}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                
                widget.title,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.mentalBrandColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}

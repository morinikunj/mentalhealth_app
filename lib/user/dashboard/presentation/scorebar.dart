import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/piechart.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ProgressCard extends StatefulWidget {
  final happy;
  final sad;
  final angry;
  final normal;
  const ProgressCard({super.key, this.happy, this.angry, this.normal, this.sad});

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(
              'Mood Tracking',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 165,
            width: MediaQuery.of(context).size.width / 1,
            child: PieChartSample2(Happy: widget.happy,
            sad: widget.sad,
            angry: widget.angry,
            normal: widget.normal,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 1,
              color: Colors.black12,
            )
          ]),
    );
  }
}

class MoodCard extends StatelessWidget {
  final String detail;
  final color;
  Function()? onpress;
  MoodCard({super.key, required this.detail, this.color, this.onpress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(10),
        child: Text(
          detail,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

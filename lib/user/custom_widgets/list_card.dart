import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ListCard extends StatelessWidget {
  final String imgurl;
  final String title;
  final String subtitle;
  final String experience;
  ListCard(
      {super.key,
      required this.imgurl,
      required this.title,
      required this.subtitle,
      this.experience = "0.0"});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 0.5,
            ),
          ]),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image(image: NetworkImage(imgurl), fit: BoxFit.cover,),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                  ),
                ],
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              
              Text(
                  'Experience : ${experience}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

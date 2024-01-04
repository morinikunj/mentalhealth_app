import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/authentication/register/register_screen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboardpage extends StatelessWidget {
  final controller;
  final String image;
  final String title;
  final String subtitle;
  final String btntitle;
  final Function()? onPressed;

  onboardpage({
    super.key,
    required this.controller,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.btntitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                   Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                },
                child: Text(
                  Customtext.skip,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: AppColors.mentalDark,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 380.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: AppColors.mentalBrandColor,
            ),
            onDotClicked: (index) {},
          ),
          // SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(right: 120, top: 20, left: 5),
            child: RichText(
              text: TextSpan(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.mentalBrandColor.withOpacity(0.8),
                  ),
                  children: [
                    TextSpan(
                      text: subtitle,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mentalDark,
                      ),
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: onPressed,
            child: RoundBtn(title: btntitle),
          ),
        ],
      ),
    );
  }
}

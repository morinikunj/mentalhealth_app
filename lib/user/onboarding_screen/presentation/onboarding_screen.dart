import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/onboarding_screen/presentation/screen_widget.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            onboardpage(
              controller: controller,
              title: 'Find mutual understanding',
              subtitle: ' with your children',
              btntitle: 'Next',
              image: 'assets/images/dadkid.jpg',
              onPressed: () {
                controller.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              },
            ),
            onboardpage(
                controller: controller,
                title: 'Get to know your fears',
                subtitle: ' and learn how to overcome them',
                btntitle: 'Next',
                image: 'assets/images/helping.jpg',
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }),
            onboardpage(
              controller: controller,
              title: 'Accept your self',
              subtitle: ' increase self-esteem',
              btntitle: 'Get Started',
              image: 'assets/images/jumping.jpg',
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
            // Container(
            //   color: Colors.red,
            // ),
            // Container(
            //   color: Colors.blue,
            // ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';
//import 'package:typewritertext/typewritertext.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
    Timer(Duration(seconds: 2), () {
      SkipLogin.whereGoto(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Customtext.mental,
              style: TextStyle(
                color: AppColors.mentalBrandColor,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              Customtext.health,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.mentalDark,
    );
  }
}

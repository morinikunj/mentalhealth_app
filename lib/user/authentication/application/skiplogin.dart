
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/dashboard.dart';
import 'package:mentalhealth_app/user/navigationbar/presentation/navbar.dart';
import 'package:mentalhealth_app/user/onboarding_screen/presentation/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkipLogin {
  static String keylogin = 'login';

  static whereGoto(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(keylogin);

    if (isLogin != null) {
      if (isLogin) {
        if (User.currentuser != null) {
           gotoHome(context);
        } else {
           gotoLogin(context);
        }
       
      } else {
        gotoLogin(context);
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen()));
    }
    
  }

  static gotoHome(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Navbar()));
  }

  static gotoLogin(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

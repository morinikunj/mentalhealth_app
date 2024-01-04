import 'package:mentalhealth_app/experts/presentation/home.dart';
import 'package:mentalhealth_app/experts/presentation/login.dart';
import 'package:mentalhealth_app/experts/presentation/register.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginSkip {
  static String keylogin = 'login';

  static whereGoto(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(keylogin);

    if (isLogin != null) {
      if (isLogin) {
        if (User.currentuser != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ExpertRegister()));
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/navigationbar/presentation/navbar.dart';

class LoginController extends StatelessWidget {
  const LoginController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navbar();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

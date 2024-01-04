
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentalhealth_app/user/authentication/application/logincontroller.dart';
import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static var currentuser = auth.currentUser;

  void register(String email, String password, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        pref.setBool(SkipLogin.keylogin, true);
      }).whenComplete(() => LoginController());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void login(String email, String password, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        pref.setBool(SkipLogin.keylogin, true);
        SkipLogin.gotoHome(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await auth.signOut().then((value) {
      pref.setBool(SkipLogin.keylogin, false);
      SkipLogin.gotoLogin(context);
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email);
  }
}

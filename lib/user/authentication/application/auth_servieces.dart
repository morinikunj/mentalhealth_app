import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/navigationbar/presentation/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static final user = FirebaseAuth.instance.currentUser;

  static signupUser(
      imageUrl,
      String email,
      String password,
      String name,
      String dob,
      String phoneNo,
      String location,
      String profession,
      BuildContext context,
      load()) async {
    DatabaseServices _databaseServices = DatabaseServices();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      // await FirestoreServices.saveUser(name, email, dob, phoneNo, location,
      //     profession, userCredential.user!.uid);

      String userid = userCredential.user!.uid;

      UserModel userModel = UserModel(
          imageUrl: imageUrl,
          userid: userid,
          name: name,
          email: email,
          phoneno: phoneNo,
          dob: dob,
          profession: profession,
          location: location);

      await _databaseServices.saveUserData(userModel);

      pref.setBool(SkipLogin.keylogin, true);

      await _databaseServices.createMood(userid, '0', '0', '0', '100');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      load();
    }
  }

  static signinUser(email, password, BuildContext context, load()) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        pref.setBool(SkipLogin.keylogin, true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navbar()));

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You are Logged in')));
        load();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static void Logout(context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      // await auth.signOut();
      pref.setBool(SkipLogin.keylogin, true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {}
  }
}

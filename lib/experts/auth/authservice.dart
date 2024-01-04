// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/firebasefunction.dart';
import 'package:mentalhealth_app/experts/auth/model/model.dart';
import 'package:mentalhealth_app/experts/presentation/home.dart';
import 'package:mentalhealth_app/experts/presentation/login.dart';
import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static final user = FirebaseAuth.instance.currentUser;

  static signupUser(
      fees,
      city,
      street,
      about,
      imageUrl,
      email,
      password,
      name,
      phoneNo,
      profession,
      experience,
      BuildContext context,
      Function() load) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);

      String userid = userCredential.user!.uid;

      ExpertModel expertModel = ExpertModel(
        fees: fees,
        street: street,
        city: city,
        about: about,
        imageUrl: imageUrl,
        userid: userid,
        name: name,
        email: email,
        phoneno: phoneNo,
        experience: experience,
        profession: profession,
      );

      await Database().saveUserData(expertModel);

      pref.setBool(SkipLogin.keylogin, true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
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

  static loginUser(email, password, BuildContext context, load()) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('You are Logged in')));
      
        pref.setBool(SkipLogin.keylogin, true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
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
    } catch (e) {}
  }

  static logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // await FirebaseAuth.instance.signOut();
    pref.setBool(SkipLogin.keylogin, false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}

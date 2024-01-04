// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/authentication/register/register_screen.dart';

import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/input_widget.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 30,
              child: HeaderText(
                label: 'Login ',
                color: AppColors.mentalBrandLightColor,
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Input(
                            label: 'Email',
                            errortext: 'Enter Email!',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Input(
                            errortext: 'Enter Password!',
                            label: 'Password',
                            password: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mentalBrandColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final email = _email.text.trim().toString();
                          // ignore: unused_local_variable
                          final password = _password.text.trim().toString();

                          setState(() {
                            loading = true;
                          });

                          AuthServices.loginUser(email, password, context, () {
                            setState(() {
                              loading = false;
                            });
                          });

                          // AuthServices.signinUser(email, password, context, (){
                          //   setState(() {
                          //     loading = false;
                          //   });
                          //

                          // await FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: email, password: password)
                          //     .then((value) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Navbar()));
                          //   setState(() {
                          //     loading = false;
                          //   });
                          //   pref.setBool(SkipLogin.keylogin, true);
                          //    ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('You are Logged in')));
                          // });

                          //   try {
                          //     // await FirebaseAuth.instance.signInWithEmailAndPassword(
                          //     //     email: email, password: password);

                          //     Navigator.pushReplacement(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => Home()));

                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(content: Text('You are Logged in')));
                          //   } on FirebaseAuthException catch (e) {
                          //     if (e.code == 'user-not-found') {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //               content: Text(
                          //                   'No user Found with this Email')));
                          //     } else if (e.code == 'wrong-password') {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //               content: Text('Password did not match')));
                          //     }
                          //   } catch (e) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(content: Text(e.toString())));
                          //   } finally {
                          //     setState(() {
                          //       loading = false;
                          //     });
                          //   }
                        }
                      },
                      child: loading ? LoadingBtn() : RoundBtn(title: 'Login'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.mentalBrandColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                height: 800,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.mentalBrandLightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/authentication/forget_password/password_recoveryscreen.dart';
import 'package:mentalhealth_app/user/authentication/register/abc.dart';
import 'package:mentalhealth_app/user/authentication/register/register_screen.dart';

import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/input_widget.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                padding: const EdgeInsets.all(30),
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
                          const SizedBox(
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
                    const SizedBox(
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
                                    builder: (context) => PassrecoveryPage()));
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
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final email = _email.text;
                          final password = _password.text;

                          AuthServices.signinUser(email, password, context, () {
                            setState(() {
                              loading = false;
                            });
                          });

                          // await FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: email, password: password);

                          // try {
                          //   // .signInWithEmailAndPassword(
                          //   //     email: email, password: password);

                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Navbar()));

                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('You are Logged in')));
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'user-not-found') {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text(
                          //                 'No user Found with this Email')));
                          //   } else if (e.code == 'wrong-password') {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text('Password did not match')));
                          //   }
                          // } catch (e) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text(e.toString())));
                          // } finally {
                          //   setState(() {
                          //     loading = false;
                          //   });
                          // }
                        }
                      },
                      child: loading ? LoadingBtn() : RoundBtn(title: 'Login'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UserRegister()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegisterPage()));
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
                    borderRadius: const BorderRadius.only(
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

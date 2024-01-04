import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/authentication/register/register_screen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/input_widget.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';

class PassrecoveryPage extends StatefulWidget {
  PassrecoveryPage({super.key});

  @override
  State<PassrecoveryPage> createState() => _PassrecoveryPageState();
}

class _PassrecoveryPageState extends State<PassrecoveryPage> {
  User _user = User();
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandColor,
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 30,
              child: HeaderText(label: 'Password Recovery', color: AppColors.mentalBrandLightColor,),
            ),
            Positioned(
              top: 90,
              left: 30,
              right: 60,
              child: Text(
                Customtext.password_des,
                style: TextStyle(
                  color: AppColors.mentalBrandLightColor,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 170,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Input(
                        data: _email,
                        label: 'Email',
                        errortext: 'Enter Email!',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final email = _email.text.toString();
                          _user.forgetPassword(email);
                           ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Forget Password link is sent successfully on your email.')));

                          
                        }
                      },
                      child: RoundBtn(title: 'Submit'),
                    ),
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

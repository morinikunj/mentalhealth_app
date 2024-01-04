import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/widgets/input.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
//import 'package:mentalhealth_app/user/authentication/application/skiplogin.dart';
import 'package:mentalhealth_app/user/authentication/application/upload_image.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
 const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _location = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SkipLogin.whereGoto(context);
    ImageUpload.imageFile = null;
    ImageUpload.pickedFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandColor,
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        automaticallyImplyLeading: false,
        title: HeaderText(
          label: 'Create an Account',
          color: AppColors.mentalBrandLightColor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 100,
                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      image: ImageUpload.imageFile == null
                          ? DecorationImage(
                              image:
                                  AssetImage('assets/images/profileicon.jpg'),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image:
                                  FileImage(File(ImageUpload.imageFile!.path)),
                              fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        ImageUpload().pickImage(() {
                          setState(() {
                            ImageUpload.imageFile = ImageUpload.pickedFile;
                          });
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.deepPurple.shade300,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    left: 170,
                    top: 65,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _name,
                          label: 'Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _email,
                          label: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _phone,
                          label: 'Phone No',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _dob,
                          label: 'Date of Birth',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _profession,
                          label: 'Profession',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _location,
                          label: 'Location',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: InputField(
                          data: _password,
                          secure: true,
                          label: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    final email = _email.text.toString();
                    final password = _password.text.toString();
                    final name = _name.text.toString();
                    final phone = _phone.text.toString();
                    final dob = _dob.text.toString();
                    final profession = _profession.text.toString();
                    final location = _location.text.toString();

                    String? imageUrl = await ImageUpload().uploadImage();

                    AuthServices.signupUser(imageUrl, email, password, name,
                        dob, phone, location, profession, context, () {
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                },
                child: loading ? LoadingBtn() : RoundBtn(title: 'Register'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Login',
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
            ),
          ),
        ),
      ),
    );
  }
}

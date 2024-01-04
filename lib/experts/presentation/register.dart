import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/experts/presentation/login.dart';
import 'package:mentalhealth_app/experts/utils/texts.dart';
import 'package:mentalhealth_app/experts/widgets/header.dart';
import 'package:mentalhealth_app/experts/widgets/input.dart';
import 'package:mentalhealth_app/user/authentication/application/upload_image.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ExpertRegister extends StatefulWidget {
  const ExpertRegister({super.key});

  @override
  State<ExpertRegister> createState() => _ExpertRegisterState();
}

class _ExpertRegisterState extends State<ExpertRegister> {
  final _formKey = GlobalKey<FormState>();
  bool load = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController fees = TextEditingController();

  XFile? _imageFile;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking image: $e");
    }

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<String> uploadImage(XFile imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(File(_imageFile!.path));

    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: HeaderText(color: Colors.white, label: 'Create an Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 150),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        image: _imageFile == null
                            ? DecorationImage(
                                image:
                                    AssetImage('assets/images/profileicon.jpg'),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: FileImage(File(_imageFile!.path)),
                                fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: _pickImage,
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
                      left: 220,
                      top: 65,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: name,
                            label: 'Name',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: email,
                            label: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: phone,
                            label: 'Phone No',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: profession,
                            label: 'Profession',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: exp,
                            label: 'Experience',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: fees,
                            label: 'Fees',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: street,
                            label: 'Street Line',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            data: location,
                            label: 'City',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: about,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Tell something about your self',
                            labelText: 'About',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: InputField(
                            secure: true,
                            data: pass,
                            label: 'Password',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                load = true;
                              });

                              String? imageUrl = await uploadImage(_imageFile!);

                              AuthServices.signupUser(
                                fees.text.toString(),
                                  location.text.toString(),
                                  street.text.toString(),
                                  about.text.toString(),
                                  imageUrl == null ? 'abc' : imageUrl!,
                                  email.text.toString(),
                                  pass.text.toString(),
                                  name.text.toString(),
                                  phone.text.toString(),
                                  profession.text.toString(),
                                  exp.text.toString(),
                                  context, () {
                                setState(() {
                                  load = false;
                                });
                              });
                            }
                          },
                          child:
                              load ? LoadingBtn() : RoundBtn(title: 'Register'),
                        ),
                        SizedBox(
                          height: 30,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
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
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

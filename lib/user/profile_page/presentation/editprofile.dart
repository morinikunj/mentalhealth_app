import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/application/upload_image.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/navigationbar/presentation/navbar.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/editprofilewidget.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  final imageUrl;
  final phoneno;
  final dob;
  final profession;
  final location;
  final name;
  final email;

  EditProfilePage(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.email,
      required this.phoneno,
      required this.dob,
      required this.location,
      required this.profession});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController location = TextEditingController();

  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
    no.text = widget.phoneno;
    dob.text = widget.dob;
    work.text = widget.profession;
    location.text = widget.location;

    ImageUpload.imageFile = null;
    ImageUpload.pickedFile = null;
  }

  void updateDetail() async {
    await AuthServices.user!.updateDisplayName(name.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.mentalBrandColor,
        title: AppBarTitle(title: 'Edit Profile',),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.mentalBrandColor,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.black12,
                          width: 2,
                          style: BorderStyle.solid),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ImageUpload.imageFile == null
                          ? Image(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(ImageUpload.imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 70,
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
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mentalBrandColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 35,
            ),
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            EditProfileWidget(
              iconsize: 25.0,
              icon: Icons.person,
              label: 'Name',
              data: name,
            ),
            SizedBox(
              height: 10,
            ),
            EditProfileWidget(
              space: 30.0,
              icon: Icons.email,
              label: 'Email Id',
              data: email,
            ),
            SizedBox(
              height: 10,
            ),
            EditProfileWidget(
              space: 19.0,
              icon: Icons.call,
              label: 'Phone No',
              data: no,
            ),
            SizedBox(
              height: 10,
            ),
            EditProfileWidget(
              space: 55.0,
              icon: Icons.date_range,
              label: 'DOB',
              data: dob,
            ),
            SizedBox(
              height: 10,
            ),
            EditProfileWidget(
              space: 10.0,
              icon: Icons.work,
              label: 'Profession',
              data: work,
            ),
            SizedBox(
              height: 10,
            ),
            EditProfileWidget(
              space: 23.0,
              icon: Icons.location_city,
              label: 'Location',
              data: location,
            ),
            Divider(
              height: 60,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 80, right: 80),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    load = true;
                  });
                  try {
                    String? image = await ImageUpload().uploadImage();
                    UserModel userModel = UserModel(
                        imageUrl: image== null ? widget.imageUrl : image ,
                        name: name.text.toString(),
                        email: email.text.toString(),
                        phoneno: no.text.toString(),
                        dob: dob.text.toString(),
                        profession: work.text.toString(),
                        location: location.text.toString());
                    setState(() {
                      DatabaseServices.updateDetails(userModel);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Data Updated Successfully.')));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Navbar()));
                  } catch (e) {
                  } finally {
                    setState(() {
                      load = false;
                    });
                  }
                },
                child: load
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ClickBtn(title: 'Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/experts/auth/firebasefunction.dart';
import 'package:mentalhealth_app/experts/auth/model/model.dart';
import 'package:mentalhealth_app/experts/presentation/home.dart';
import 'package:mentalhealth_app/experts/widgets/input.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late Future<ExpertModel> _userfuture;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userfuture = Database.fetchUserDeatails();
  }

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.mentalBrandColor,
        title: AppBarTitle(
          title: 'Edit Profile',
        ),
      ),
      body: FutureBuilder<ExpertModel>(
          future: _userfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ExpertModel expertModel = snapshot.data!;
              name.text = expertModel.name!;
              email.text = expertModel.email!;
              phone.text = expertModel.phoneno!;
              profession.text = expertModel.profession!;
              exp.text = expertModel.experience!;
              fees.text = expertModel.fees!;
              street.text = expertModel.street!;
              location.text = expertModel.city!;
              about.text = expertModel.about!;
              final image = expertModel.imageUrl!;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Stack(children: [
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 140,
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
                              child: _imageFile == null
                                  ? Image(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          left: 210,
                          child: InkWell(
                            onTap: _pickImage,
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
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
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
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                load = true;
                              });

                              String? imageUrl = await uploadImage(_imageFile!);
                              ExpertModel model = ExpertModel(
                                fees: fees.text.toString(),
                                street: street.text.toString(),
                                about: about.text.toString(),
                                  imageUrl: imageUrl != null
                                      ? imageUrl
                                      : expertModel.imageUrl,
                                  userid: expertModel.userid,
                                  name: name.text.toString(),
                                  email: email.text.toString(),
                                  phoneno: phone.text.toString(),
                                  experience: exp.text.toString(),
                                  profession: profession.text.toString(),
                                  city: location.text.toString());
                              AuthServices.user!.updateDisplayName(name.text!);
                              AuthServices.user!.updateEmail(email.text!);

                              Database().updateProfile(model);

                              setState(() {
                                load = false;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Profile Updated Successfilly.')));
                            },
                            child:
                                load ? LoadingBtn() : RoundBtn(title: 'Save'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

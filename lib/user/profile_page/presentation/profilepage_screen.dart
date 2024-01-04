import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/forget_password/password_recoveryscreen.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/custom_widgets/alertdialog.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/custom_widgets/settingpage_widget.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/notificationpage.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/profiledetail.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserModel> _userfuture;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userfuture = DatabaseServices.fetchUserDeatails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        title: AppBarTitle(title: 'Settings',),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.mentalBrandColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
        future: _userfuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userModel = snapshot!.data;
            String? image = userModel!.imageUrl;
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mentalBrandColor,
                    border: Border.all(
                        color: AppColors.mentalBrandColor,
                        width: 2,
                        style: BorderStyle.solid),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 20,),

                Text(
                      user!.displayName!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    ],
                  ),
                
                
                  Divider(
                    height: 50,
                  ),
                  ProfilepageWidget(
                      color: Colors.blue,
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileDetailPage()));
                      },
                      bgicon: Colors.blue.shade100,
                      title: 'Profile',
                      icon: CupertinoIcons.person),
                  SizedBox(
                    height: 10,
                  ),
                  // ProfilepageWidget(
                  //     color: Colors.deepPurple,
                  //     onpressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => NotifyPage()));
                  //     },
                  //     bgicon: Colors.deepPurple.shade100,
                  //     title: 'Notifications',
                  //     icon: Icons.notifications_none_outlined),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  ProfilepageWidget(
                      color: Colors.green,
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassrecoveryPage()));
                      },
                      bgicon: Colors.green.shade100,
                      title: 'Change Password',
                      icon: Icons.lock_outlined),
                  SizedBox(
                    height: 10,
                  ),
                  ProfilepageWidget(
                      color: Colors.indigo,
                      onpressed: () {},
                      bgicon: Colors.indigo.shade100,
                      title: 'Privacy',
                      icon: Icons.privacy_tip_outlined),
                  SizedBox(height: 10),
                  ProfilepageWidget(
                      color: Colors.orange,
                      onpressed: () {},
                      bgicon: Colors.orange.shade100,
                      title: 'About Us',
                      icon: Icons.info_outline_rounded),
                  Divider(
                    height: 30,
                  ),
                  ProfilepageWidget(
                      color: Colors.redAccent,
                      onpressed: () {
                        showAlertBox(context);
                      },
                      bgicon: Colors.redAccent.shade100,
                      title: 'Logout',
                      icon: Icons.logout_outlined),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      ),
    );
  }
}

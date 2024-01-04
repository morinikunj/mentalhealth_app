import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/customdetail_widget.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/editprofile.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  late Future<UserModel> _userfuture;
 

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
        title: AppBarTitle(title: 'Profile Page',),
        centerTitle: true,
      ),
      body: FutureBuilder<UserModel>(
        future: _userfuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            UserModel userdata = snapshot.data!;
            final name = userdata.name;
            final email = userdata.email;
            final no = userdata.phoneno;
            final dob = userdata.dob;
            final profession = userdata.profession;
            final location = userdata.location;
            final imageUrl = userdata.imageUrl;

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.mentalBrandColor,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: Colors.black12,
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                DetailWidget(
                  iconsize: 25.0,
                  icon: Icons.person,
                  label: 'Name',
                  data: name,
                ),
                SizedBox(
                  height: 20,
                ),
                DetailWidget(
                  space: 30.0,
                  icon: Icons.email,
                  label: 'Email Id',
                  data: email,
                ),
                SizedBox(
                  height: 20,
                ),
                DetailWidget(
                  space: 19.0,
                  icon: Icons.call,
                  label: 'Phone No',
                  data: no,
                ),
                SizedBox(
                  height: 20,
                ),
                DetailWidget(
                  space: 55.0,
                  icon: Icons.date_range,
                  label: 'DOB',
                  data: dob,
                ),
                SizedBox(
                  height: 20,
                ),
                DetailWidget(
                  space: 10.0,
                  icon: Icons.work,
                  label: 'Profession',
                  data: profession,
                ),
                SizedBox(
                  height: 20,
                ),
                DetailWidget(
                  space: 23.0,
                  icon: Icons.location_city,
                  label: 'Location',
                  data: location,
                ),
                Divider(
                  height: 40,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 60, right: 60),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                  imageUrl: imageUrl,
                                  name: name,
                                  email: email,
                                  phoneno: no,
                                  dob: dob,
                                  location: location,
                                  profession: profession)));
                    },
                    child: ClickBtn(title: 'Edit Profile'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

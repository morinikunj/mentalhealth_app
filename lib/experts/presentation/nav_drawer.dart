import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/experts/presentation/appointment_screen.dart';
import 'package:mentalhealth_app/experts/presentation/home.dart';
import 'package:mentalhealth_app/experts/presentation/profile.dart';
import 'package:mentalhealth_app/experts/presentation/wallet.dart';
import 'package:mentalhealth_app/user/authentication/forget_password/password_recoveryscreen.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class NavDrawer extends StatelessWidget {
  final image;
  final name;
  final email;
  const NavDrawer(
      {super.key,
      required this.email,
      required this.image,
      required this.name});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: AppColors.mentalBrandColor,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: image == null
                        ? DecorationImage(
                            image: AssetImage('assets/images/02.jpg'))
                        : DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name == null ? 'no' : name,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  email == null ? 'no' : email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.wallet),
            //   title: Text('Wallet'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Wallet()));
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Appointments'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AppointmentList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PassrecoveryPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(' Edit Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileEditPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                AuthServices.logout(context);
              },
            ),
          ],
        ),
      );
}

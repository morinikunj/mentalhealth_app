import 'dart:developer';
import 'package:mentalhealth_app/experts/widgets/header.dart';
import 'package:mentalhealth_app/main.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/sessions/model/session_model.dart';
import 'package:mentalhealth_app/user/sessions/presentation/deatailpage.dart';
import 'package:mentalhealth_app/user/sessions/presentation/session_card.dart';
import 'package:mentalhealth_app/user/sessions/presentation/sessions_list.dart';
import 'package:mentalhealth_app/video_call/presentation/call_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/model/mood_model.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/dashboard/Application/greetings.dart';
import 'package:mentalhealth_app/user/dashboard/Application/toastmsg.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/mygridview.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/piechart.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/scorebar.dart';
import 'package:mentalhealth_app/user/profile_page/presentation/profiledetail.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class DashboardPage extends StatefulWidget {
  String? userImage;
  DashboardPage({super.key, this.userImage});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<UserModel> _userfuture;
  final user = FirebaseAuth.instance.currentUser;
  late Future<MoodModel> _mood;

  final String _url = 'https://www.youtube.com/watch?v=vgm1u2gPxzw';

  late int Happy;
  late int Sad;
  late int Angry;
  late int Normal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userfuture = DatabaseServices.fetchUserDeatails();
    widget.userImage = null;

    _mood = DatabaseServices().MoodDeatails();
  }

  load() {
    _mood = DatabaseServices().MoodDeatails();
  }

  void updateMood(int index) {
    setState(() {
      if (index == 1) {
        Happy++;
      } else if (index == 2) {
        Sad++;
      } else if (index == 3) {
        Angry++;
      } else if (index == 4) {
        Normal++;
      }

      int total = Happy + Sad + Angry + Normal;

      if (total > 0) {
        Happy = (Happy / total * 100).round();
        Sad = (Sad / total * 100).round();
        Angry = (Angry / total * 100).round();
        Normal = (Normal / total * 100).round();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<UserModel>(
              future: _userfuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel? userModel = snapshot!.data;
                  widget.userImage = userModel!.imageUrl!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    user!.displayName.toString() == null
                                        ? 'hello User'
                                        : 'Hello, ${user!.displayName}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    Greetings.showGreet(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mentalBrandColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 140,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileDetailPage()));
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      image: NetworkImage(userModel!.imageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.deepPurple,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<MoodModel>(
                              future: _mood,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  MoodModel model = snapshot.data!;

                                  Happy = int.parse(model.happy);
                                  Sad = int.parse(model.sad);
                                  Angry = int.parse(model.angry);
                                  Normal = int.parse(model.normal);

                                  return ProgressCard(
                                    happy: model.happy,
                                    sad: model.sad,
                                    angry: model.angry,
                                    normal: model.normal,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'How are you feeling?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              MoodCard(
                                detail: '😊Happy',
                                color: AppColors.contentColorYellow,
                                onpress: () {
                                  updateMood(1);
                                  setState(() {
                                    DatabaseServices().updateMood(
                                        AuthServices.user!.uid,
                                        Happy.toString(),
                                        Sad.toString(),
                                        Angry.toString(),
                                        Normal.toString());
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('😊Happy')));
                                  load();
                                },
                              ),
                              MoodCard(
                                detail: '😢Sad',
                                color: AppColors.contentColorBlue,
                                onpress: () {
                                  updateMood(2);
                                  setState(() {
                                    DatabaseServices().updateMood(
                                        AuthServices.user!.uid,
                                        Happy.toString(),
                                        Sad.toString(),
                                        Angry.toString(),
                                        Normal.toString());
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('😢Sad')));
                                      load();
                                },
                              ),
                              MoodCard(
                                detail: '😡Angry',
                                color: AppColors.contentColorPurple,
                                onpress: () {
                                  updateMood(3);
                                  setState(() {
                                    DatabaseServices().updateMood(
                                        AuthServices.user!.uid,
                                        Happy.toString(),
                                        Sad.toString(),
                                        Angry.toString(),
                                        Normal.toString());
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('😡Angry')));
                                      load();
                                },
                              ),
                              MoodCard(
                                detail: '😐Normal',
                                color: AppColors.contentColorGreen,
                                onpress: () {
                                  updateMood(4);
                                  setState(() {
                                    DatabaseServices().updateMood(
                                        AuthServices.user!.uid,
                                        Happy.toString(),
                                        Sad.toString(),
                                        Angry.toString(),
                                        Normal.toString());
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('😐Normal')));
                                      load();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 5),
                          //   child: Text(
                          //     'Explore More',
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: 15,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // MyGridView(),

                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'Explore More',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          SessionList(),

                          SizedBox(height: 20,),


                          // ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   SessionDetailPage()));
                          //     },
                          //     child: Text('jdjd'))

                          // SizedBox(
                          //   height: 20,
                          // ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       SessionModel sessionModel = SessionModel(
                          //         url: 'abc',
                          //         title: 'kl',
                          //         description: 'dd',

                          //       );
                          //       DatabaseServices().createSession(sessionModel);
                          //     },
                          //     child: Text('mmm'))
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.camera_alt_rounded),
      //   backgroundColor: AppColors.mentalBrandColor,
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => EmotionDetection()));
      //   },
      // ),
    );
  }
}

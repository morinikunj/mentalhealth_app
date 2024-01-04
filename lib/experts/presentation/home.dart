import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/appointments/pending.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/experts/auth/firebasefunction.dart';
import 'package:mentalhealth_app/experts/auth/model/model.dart';
import 'package:mentalhealth_app/experts/presentation/nav_drawer.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/video_call/presentation/call_ui.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<ExpertModel> _userfuture;
  String? image;
  String? name;
  String? email;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userfuture = Database.fetchUserDeatails();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder<ExpertModel>(
          future: _userfuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ExpertModel? expertModel = snapshot!.data;
              image = expertModel!.imageUrl;
              name = expertModel!.name;
              email = expertModel!.email;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                       PendingAppointment(),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data == null) {
              return Text('data');
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      drawer: NavDrawer(
        image: image,
        name: name,
        email: email,
      ),
    );
  }
}

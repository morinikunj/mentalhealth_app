import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/canceled.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/completed.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/status_widget.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/upcoming.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _btnIndex = 0;
  List<Widget> _SchedulePageWidgets = [
    UpcomingSchedule(),
   
    CompletedSchedule(),

    CanceledSchedule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Appointments',),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.mentalBrandColor,


      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: 
              // ),
             
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    StatusWidget(
                      txtcolor: _btnIndex == 0? Colors.white: Colors.black54,
                      bgcolor:  _btnIndex == 0?AppColors.mentalBrandColor:Colors.transparent,
                      title: 'Upcoming',
                      onpressed: () {
                        setState(() {
                          _btnIndex = 0;
                        });
                      },
                    ),
                    StatusWidget(
                      txtcolor: _btnIndex == 1? Colors.white: Colors.black54,
                      bgcolor:  _btnIndex == 1?AppColors.mentalBrandColor:Colors.transparent,
                      title: 'Completed',
                      onpressed: () {
                        setState(() {
                          _btnIndex = 1;
                        });
                      },
                    ),
                    StatusWidget(
                      txtcolor: _btnIndex == 2? Colors.white: Colors.black54,
                      bgcolor:  _btnIndex == 2? AppColors.mentalBrandColor:Colors.transparent,
                      title: 'Canceled',
                      onpressed: () {
                        setState(() {
                          _btnIndex = 2;
                        });
                      },
                    ),
              
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              _SchedulePageWidgets[_btnIndex],
            ],
          ),
      ),
    );
  }
}

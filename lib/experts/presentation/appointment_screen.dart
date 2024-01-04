import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/appointments/canceled.dart';
import 'package:mentalhealth_app/experts/appointments/completed.dart';
import 'package:mentalhealth_app/experts/appointments/upcoming.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/status_widget.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({super.key});

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {

   int _btnIndex = 0;
  List<Widget> _SchedulePageWidgets = [
  UpcomingAppointment(),
  CompletedAppointment(),
  CanceledAppointment(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Appointments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
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
                    SizedBox(width: 30,),
                    
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
                    SizedBox(width: 30,),
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

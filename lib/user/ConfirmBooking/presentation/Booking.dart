import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/presentation/paymentbtn.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/card.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class FinalBookingPage extends StatelessWidget {
  final imageurl;
  final String? time;
  final String? date;
  final String? name;
  final String? fees;

  FinalBookingPage({super.key, required this.imageurl, this.time, this.date, this.name, this.fees});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Make Appointment',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          ScheduleCard(
            imageurl: imageurl,
            name: name!,
            status: 'Pending',
            about: 'Fees : Rs ${fees}',
            date: date!,
            time: time!,
            btn3: '',
          ),
          SizedBox(
            height: 250,
          ),
          PaymentBtn(
            
            imageurl: imageurl,
            expertsname: name,
            fees: fees,
            time: time,
            date: date,
          ),
        ],
      ),
    );
  }
}

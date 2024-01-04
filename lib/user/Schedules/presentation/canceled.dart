import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/card.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/schedules_screen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';

class CanceledSchedule extends StatefulWidget {
  const CanceledSchedule({super.key});

  @override
  State<CanceledSchedule> createState() => _CanceledScheduleState();
}

class _CanceledScheduleState extends State<CanceledSchedule> {

    Stream<List<Appointment>> _fetchAppointment =
      BookingDatabaseSearvices().fetchUsers(AuthServices.user!.uid, 'Canceled');
   @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<Appointment>>(
        stream: _fetchAppointment,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Appointment>? appointments = snapshot!.data;
            return ListView.builder(
                itemCount: appointments!.length,
                itemBuilder: (context, index) {
                  Appointment appointment = appointments[index];
                  return ScheduleCard(
                      name: appointment.expertname,
                      about: 'Paid Fees : Rs ${appointment.fees}',
                      date: appointment.date,
                      imageurl: appointment.image,
                      status: appointment.status,
                      btn3: '',
                      time: appointment.time);
                });
          } else if (snapshot!.data == null || snapshot!.data!.isEmpty) {
            return Container(
              padding: EdgeInsets.only(left: 100, top: 220),
              child: Text(
                'No Appointments',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text('Error: ${snapshot.error}');
          }
        },
      ),
    );
  }
}

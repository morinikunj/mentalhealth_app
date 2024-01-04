import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/card.dart';

class CompletedAppointment extends StatefulWidget {
  const CompletedAppointment({super.key});

  @override
  State<CompletedAppointment> createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {

    final Stream<List<Appointment>> _fetchAppointment =
      BookingDatabaseSearvices().fetchAppointmentList(AuthServices.user!.displayName!, 'Completed');
  

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
                    btn3: '',
                      
                      name: appointment.expertname,
                      about: 'Fees : Rs ${appointment.fees}',
                      date: appointment.date,
                      imageurl: appointment.userimageurl!,
                      status: 'Completed',
                      
                      time: appointment.time);
                });
          } else if (snapshot!.data == null || snapshot!.data!.isEmpty) {
            return Container(
              padding: EdgeInsets.only(left: 150, top: 260),
              child: const Text(
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

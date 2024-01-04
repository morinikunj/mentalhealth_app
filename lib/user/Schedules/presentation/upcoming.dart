import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/card.dart';
import 'package:mentalhealth_app/video_call/presentation/call_ui.dart';

class UpcomingSchedule extends StatefulWidget {
  const UpcomingSchedule({super.key});

  @override
  State<UpcomingSchedule> createState() => _UpcomingScheduleState();
}

class _UpcomingScheduleState extends State<UpcomingSchedule> {
  late Stream<List<Appointment>> _fetchAppointment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAppointment = BookingDatabaseSearvices()
        .fetchUsers(AuthServices.user!.uid, 'Upcoming');
    // _futureappointment = BookingDatabaseSearvices.fetchUsers('Upcoming');
  }

  load() {
    _fetchAppointment = BookingDatabaseSearvices()
        .fetchUsers(AuthServices.user!.uid, 'Upcoming');
  }

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

                  final date = appointment.date;
                  final username = appointment.username;
                  final userId = appointment.userId;
                  final fees = appointment.fees;
                  final expertsname = appointment.expertname;
                  final time = appointment.time;
                  final status = appointment.status;
                  final image = appointment.image;
                  final userimage = appointment.userimageurl!;
                  final uniquekey = appointment.key;

                  if (appointment.status == 'Pending') {
                    return ScheduleCard(
                        name: appointment.expertname,
                        about: 'Paid Fees : Rs ${appointment.fees}',
                        date: appointment.date,
                        imageurl: image,
                        status: appointment.status,
                        btn3: '',
                        onpress: () {
                          Appointment appointment = Appointment(
                              userimageurl: userimage,
                              image: image,
                              username: username,
                              expertname: expertsname,
                              fees: fees,
                              date: date,
                              time: time,
                              userId: userId,
                              status: 'Canceled');

                          setState(() {
                            BookingDatabaseSearvices()
                                .canceledAppointment(appointment);
                            BookingDatabaseSearvices().removeExpert(uniquekey);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Appointment is Cancelled Successfully.')));
                            
                          });
                          setState(() {
                            load();
                          });
                        },
                        btntitle: 'Cancel',
                        time: appointment.time);
                  } else {
                    return ScheduleCard(
                        name: appointment.expertname,
                        about: 'Fees : Rs ${appointment.fees}',
                        date: appointment.date,
                        imageurl: image,
                        status: appointment.status,
                        btn2: 'Session',
                        onpress1: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CallPage(callID: '1')));
                        },
                        btn3: '',
                        onpress: () {
                          Appointment appointment = Appointment(
                              userimageurl: userimage,
                              image: image,
                              username: username,
                              expertname: expertsname,
                              fees: fees,
                              date: date,
                              time: time,
                              userId: userId,
                              status: 'Canceled');

                          setState(() {
                            BookingDatabaseSearvices()
                                .canceledAppointment(appointment);
                            BookingDatabaseSearvices().removeExpert(uniquekey);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Appointment is Cancelled Successfully.')));
                          });
                          setState(() {});
                        },
                        btntitle: 'Cancel',
                        time: appointment.time);
                  }
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

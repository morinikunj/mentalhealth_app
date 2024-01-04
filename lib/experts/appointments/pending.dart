import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/card.dart';

class PendingAppointment extends StatefulWidget {
  const PendingAppointment({super.key});

  @override
  State<PendingAppointment> createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {
  late Stream<List<Appointment>> _fetchAppointment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAppointment = BookingDatabaseSearvices()
        .fetchAppointmentList(AuthServices.user!.displayName!, 'Upcoming');
    // _futureappointment = BookingDatabaseSearvices.fetchUsers('Upcoming');
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
                  final userimage = appointment.userimageurl;
                  final key = appointment.key;
                  final image = appointment.image!;

                  if (appointment.status == 'Pending') {
                    return ScheduleCard(
                        name: appointment.username,
                        about: 'Fees : Rs ${appointment.fees}',
                        date: date,
                        imageurl: userimage!,
                        status: appointment.status,
                        btn2: 'Confirmed',
                        btn3: '',
                        onpress1: () {
                          // Appointment appointment = Appointment(
                          //     userimageurl: userimage!,
                          //     image: image!,
                          //     username: username,
                          //     expertname: expertsname,
                          //     fees: fees,
                          //     date: date,
                          //     time: time,
                          //     userId: userId,
                          //     status: 'Confirmed');

                          setState(() {
                            BookingDatabaseSearvices()
                                .updateStatus('Upcoming', key);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Appointment is Confirmed Successfully.')));
                          });
                        },
                        onpress: () {
                          Appointment appointment = Appointment(
                              image: image!,
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
                            BookingDatabaseSearvices().removeExpert(key);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Appointment is Cancelled Successfully.')));
                          });
                        },
                        btntitle: 'Cancel',
                        time: time);
                  } else {
                    return Container();
                  }
                });
          } else if (snapshot!.data == null || snapshot!.data!.isEmpty) {
            return Container(
              padding: EdgeInsets.only(left: 150, top: 260),
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

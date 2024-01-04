import 'dart:convert';
import 'dart:ffi';
import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';

class BookingDatabaseSearvices {
  DatabaseReference _appointmentsRef =
      FirebaseDatabase.instance.ref().child('appointments');

  Future<void> createAppointment(Appointment appointment) async {
    final booking = _appointmentsRef.child('Upcoming').push();
    appointment.key = booking.key;
    booking.set(appointment.toJson());
  }

  Future<void> updateStatus(status, key) async {
    await _appointmentsRef.child('Upcoming').child(key).update({
      'status': status,
    });
  }

  Future<void> canceledAppointment(Appointment appointment) async {
    await _appointmentsRef.child('Canceled').push().set(appointment.toJson());
  }

  Future<void> completedAppointment(Appointment appointment) async {
    await _appointmentsRef.child('Completed').push().set(appointment.toJson());
  }

  Future<void> removeExpert(key) async {
    await _appointmentsRef.child('Upcoming').child(key).remove();
  }

  Stream<List<Appointment>> fetchUsers(String uid, String status) {
    try {
      return _appointmentsRef
          .child(status)
          .orderByChild('userId')
          .equalTo(uid)
          .onValue
          .map((event) {
        Map<Object?, dynamic> expertsMap = event.snapshot!.value as dynamic;

        final appointmentList = expertsMap.entries
            .map((e) => Appointment.fromJson(e.value))
            .toList();

        return appointmentList;
      }).handleError((e) {
        print(e.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 

  // Stream<List<Appointment>> fetchAppointmentList(
  //     String expertname, String status) {
  //   return _appointmentsRef.child(status).onValue.map((event) {
  //     Map<Object?, dynamic> expertsMap = event.snapshot!.value as dynamic;
  //     List<Appointment> list;
  //     expertsMap.forEach((key, value) {
  //       Appointment appointment = Appointment.fromJson(value);
  //       a
  //     });
  //   });
  // }

  Stream<List<Appointment>> fetchAppointmentList(name, String status) {
    try {
      return _appointmentsRef
          .child(status)
          .orderByChild('expertname')
          .equalTo(name)
          .onValue
          .map((event) {
        Map<Object?, dynamic> expertsMap = event.snapshot!.value as dynamic;

        final appointmentList = expertsMap.entries
            .map((e) => Appointment.fromJson(e.value))
            .toList();

        return appointmentList;
      }).handleError((e) {
        print(e.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //  Stream<List<Appointment>> fetchAppointmentList(String expertname, String status) async {
  //   try {
  //       DataSnapshot dataSnapshot = await _appointmentsRef.child(status).get();
  //       List<Appointment> list;
  //       if (dataSnapshot.value != null) {

  //         Map<dynamic?, dynamic> values = dataSnapshot.value as dynamic;

  //         values.

  //       }
  //     }).handleError((e) {
  //       print(e.toString());
  //     });
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
}

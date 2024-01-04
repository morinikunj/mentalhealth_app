import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/schedules_screen.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/authentication/model/user_model.dart';
import 'package:mentalhealth_app/user/chatbot/presentation/chatbotscreen.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/custom_widgets/loadingbtn.dart';
import 'package:mentalhealth_app/user/dashboard/presentation/dashboard.dart';
import 'package:mentalhealth_app/user/navigationbar/presentation/navbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentBtn extends StatefulWidget {
  final imageurl;
  final expertsname;
  final time;
  final fees;
  final date;
  PaymentBtn(
      {super.key,
      this.imageurl,
      this.expertsname,
      this.fees,
      this.time,
      this.date});

  @override
  State<PaymentBtn> createState() => _PaymentBtnState();
}

class _PaymentBtnState extends State<PaymentBtn> {
  bool load = false;
  final _razorpay = Razorpay();

  late Future<UserModel> _userfuture;
  bool paid = false;

  var payment_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userfuture = DatabaseServices.fetchUserDeatails();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      paid = true;
    });
    payment_id = response.paymentId;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Payment is successfull. Click on Confirm Button.')));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Payment is failed!')));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _razorpay.clear(); // Removes all listeners
  }

  void pay(int fees) {
    try {
      var options = {
        'key': 'rzp_test_Z6xgCsCR7f4nbT',
        'amount': fees * 100, //in the smallest currency sub-unit.
        'name': 'iMinds App',
        'prefill': {
          'email': AuthServices.user!.email,
        },
      };
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: _userfuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = snapshot.data!;
            final userimage = userModel.imageUrl;
            if (paid == true) {
              return Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      load = true;
                    });
                    Appointment appointment = Appointment(
                        userimageurl: userimage,
                        image: widget.imageurl,
                        username: AuthServices.user!.displayName.toString(),
                        expertname: widget.expertsname,
                        fees: widget.fees,
                        time: widget.time,
                        date: widget.date,
                        userId: AuthServices.user!.uid,
                        paid: 'suceess',
                        payment_id: payment_id == null ? '' : payment_id,
                        status: 'Pending');
                    try {
                      BookingDatabaseSearvices().createAppointment(appointment);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Navbar()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Appointment is Booked Successfully.')));
                    } catch (e) {
                    } finally {
                      setState(() {
                        load = false;
                      });
                    }
                  },
                  child: load ? LoadingBtn() : RoundBtn(title: 'Confirm'),
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  int price = int.parse(widget.fees.toString());
                  pay(price);
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: RoundBtn(title: 'Make Payment'),
                ),
              );
            }
          } else
            return CircularProgressIndicator();
        });
  }
}

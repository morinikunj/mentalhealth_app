import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/application/databasefunction.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/model/booking_model.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int amount = 500;
  late Stream<List<Appointment>> _fetchAppointment;
  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAppointment = BookingDatabaseSearvices()
        .fetchAppointmentList(AuthServices.user!.displayName!, 'Upcoming');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.mentalBrandColor,
        title: AppBarTitle(
          title: 'Wallet',
        ),
      ),
      body: StreamBuilder<List<Appointment>>(
        stream: _fetchAppointment,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Appointment>? appointments = snapshot!.data;

            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 20,
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Text(
                            'Rs ${amount}',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.shade400,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 1,
                              color: Colors.black12,
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.compare_arrows_sharp,
                          color: Colors.black54,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appointments!.length,
                      itemBuilder: (context, index) {
                        Appointment appointment = appointments![index];

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
                        final id = appointment.payment_id!;

                        setState(() {
                          int f = int.parse(fees);
                          amount = f * appointments!.length;
                        });

                        return WalletCard(
                          name: username,
                          image: userimage,
                          payment_id: id,
                          fees: fees,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text('Wallet is empty.', style: TextStyle(
                fontSize: 20, 
                color: Colors.black54
              ),),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  var image;
  var name;
  var fees;
  var payment_id;
  WalletCard({super.key, this.image, this.fees, this.name, this.payment_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              spreadRadius: 0.5,
            ),
          ]),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: image == null
                    ? DecorationImage(image: AssetImage('assets/images/02.jpg'))
                    : DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            left: 80,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  payment_id,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                )
              ],
            ),
          ),
          Positioned(
              top: 8,
              left: 320,
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 18,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Rs ${fees}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              )),
          Positioned(top: 30, left: 320, child: Text('Recieved In')),
        ],
      ),
    );
  }
}

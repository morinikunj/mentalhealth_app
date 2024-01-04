import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/ConfirmBooking/presentation/Booking.dart';
import 'package:mentalhealth_app/user/custom_widgets/Roundbtn.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  final imageurl;
  final name;
  final fees;
  const BookingPage({super.key, required this.imageurl, required this.name, required this.fees});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _selectedDay = DateTime.now();
  int _selectedslot = 1;
  List slots = [
    '12:00 - 12:30',
    '12:30 - 01:00',
    '02:30 - 03:00',
    '03:30 - 04:00',
  ];
  void onDaySelect(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDay = day;
    });
  }

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
          'Appointment Schedule',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                rowHeight: 45,
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _selectedDay,
                onDaySelected: onDaySelect,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Choose the Right Time',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedslot = 1;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedslot == 1
                            ? AppColors.mentalBrandColor
                            : AppColors.mentalBrandLightColor,
                      ),
                      child: Center(
                        child: Text(
                          '12:00 - 12:30',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: _selectedslot == 1
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedslot = 2;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedslot == 2
                            ? AppColors.mentalBrandColor
                            : AppColors.mentalBrandLightColor,
                      ),
                      child: Center(
                        child: Text(
                          '12:30 - 01:00',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: _selectedslot == 2
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedslot = 3;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedslot == 3
                            ? AppColors.mentalBrandColor
                            : AppColors.mentalBrandLightColor,
                      ),
                      child: Center(
                        child: Text(
                          '2:30 - 03:00',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: _selectedslot == 3
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedslot = 4;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedslot == 4
                            ? AppColors.mentalBrandColor
                            : AppColors.mentalBrandLightColor,
                      ),
                      child: Center(
                        child: Text(
                          '03:30 - 04:00',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: _selectedslot == 4
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    final day = _selectedDay.day;
                    final month = _selectedDay.month;
                    final year = _selectedDay.year;
                    final String date = "${day}/${month}/${year}";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalBookingPage(
                                  imageurl: widget.imageurl,
                                  name: widget.name.toString(),
                                  fees: widget.fees.toString(),
                                  time: slots[_selectedslot - 1],
                                  date: date,
                                )));
                  },
                  child: RoundBtn(title: 'To Make an Appointment'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

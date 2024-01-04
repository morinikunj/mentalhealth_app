import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/Schedules/presentation/btn_widget.dart';
import 'package:mentalhealth_app/user/custom_widgets/smallbtn.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ScheduleCard extends StatelessWidget {
  String name;
  String about;
  String date;
  String time;
  String status;
  String imageurl;
  Function()? onpress;
  Function()? onpress1;
  String? btntitle;
  String? btn2;
  String? btn3;
  Function()? onpress2;
  ScheduleCard(
      {super.key,
      this.btn2,
      this.onpress1,
      required this.name,
      required this.about,
      required this.date,
      required this.imageurl,
      required this.status,
      this.btn3,
      this.onpress2,
      this.onpress,
      this.btntitle,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Schedule',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              about,
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 20),
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mentalBrandColor,
                            border: Border.all(
                                color: AppColors.mentalBrandColor,
                                width: 2,
                                style: BorderStyle.solid),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: imageurl == null
                                ? Image(
                                    image: AssetImage('assets/images/02.jpg'),
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    image: NetworkImage(imageurl),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            date!,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            time!,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            status!,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                   

                  Container(
                      padding: EdgeInsets.all(10),
                      child: btntitle != null
                          ? btn2 == null
                              ? InkWell(
                                  onTap: onpress,
                                  child: ClickBtn(
                                    title: btntitle!,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: onpress,
                                      child: SmallBtn(title: btntitle!),
                                    ),
                                    InkWell(
                                      onTap: onpress1,
                                      child: SmallBtn(title: btn2!),
                                    )
                                  ],
                                )
                          : Container()),


                          Container(
                    padding: EdgeInsets.all(10),
                    child: btn3 != ''? InkWell(
                            onTap: onpress2,
                            child: ClickBtn(
                              title: btn3!,
                            ),
                          ) 
                        : Container(),
                  ),

                          
                  // SizedBox(
                  //   child: btn2 !=null ? Container(

                  //     padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 20),
                  //     child: InkWell(
                  //       onTap: onpress1,
                  //       child:
                  //     ),
                  //   ) :  Container(),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

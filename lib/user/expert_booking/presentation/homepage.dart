import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/firebasefunction.dart';
import 'package:mentalhealth_app/experts/auth/model/model.dart';
import 'package:mentalhealth_app/experts/utils/texts.dart';
import 'package:mentalhealth_app/user/custom_widgets/appbar_title.dart';
import 'package:mentalhealth_app/user/custom_widgets/list_card.dart';
import 'package:mentalhealth_app/user/custom_widgets/page_header.dart';
import 'package:mentalhealth_app/user/expert_booking/presentation/detail_page.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:mentalhealth_app/user/resources/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<ExpertModel>> _userfuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userfuture = Database.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: AppBarTitle(title: Customtext.heading1,)
      ),
      body: SafeArea(
        child: StreamBuilder<List<ExpertModel>>(
            stream: _userfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ExpertModel>? expertslist = snapshot!.data;

                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.only(left: 10),
                          //   child:
                          // ),

                          ListView.builder(
                            itemCount: expertslist!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ExpertModel expertModel = expertslist![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              street: expertModel.street,
                                              about: expertModel.about,
                                              fees: expertModel.fees,
                                              image: expertModel.imageUrl,
                                              name: expertModel.name,
                                              exp: expertModel.experience,
                                              location: expertModel.city,
                                              profession:
                                                  expertModel.profession,
                                            )),
                                  );
                                },
                                child: ListCard(
                                  imgurl: expertModel.imageUrl,
                                  title: expertModel.name,
                                  subtitle: expertModel.profession,
                                  experience: expertModel.experience,
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                );
              } else if (snapshot!.data == null || snapshot!.data!.isEmpty) {
                return Container(
                  padding: EdgeInsets.only(left: 100, top: 220),
                  child: Text(
                    'No Experts Found!',
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
            }),
      ),
      
    );
  }
}

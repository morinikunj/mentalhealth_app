import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/application/databasefunction.dart';
import 'package:mentalhealth_app/user/sessions/model/session_model.dart';
import 'package:mentalhealth_app/user/sessions/presentation/deatailpage.dart';
import 'package:mentalhealth_app/user/sessions/presentation/session_card.dart';

class SessionList extends StatefulWidget {
  const SessionList({super.key});

  @override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  late Stream<List<SessionModel>> _details;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _details = DatabaseServices.fetchsessions();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SessionModel>>(
        stream: _details,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          List<SessionModel>? sessions = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                SessionModel sessionModel = sessions![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SessionDetailPage(
                                  title: sessionModel.title,
                                  des: sessionModel.description,
                                  url: sessionModel.url,
                                  num: index+1,
                                )));
                  },
                  child: SessionCard(
                    title: sessionModel.title,
                    index: index + 1,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SessionDetailPage extends StatefulWidget {
  final num;
  final url;
  final title;
  final des;
  SessionDetailPage(
      {super.key, required this.url, this.num, this.des, this.title});

  @override
  State<SessionDetailPage> createState() => _SessionDetailPageState();
}

class _SessionDetailPageState extends State<SessionDetailPage> {
  late String? url;
  late YoutubePlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(url!) ?? '',
    flags: YoutubePlayerFlags(mute: false, autoPlay: false),
  );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentalBrandLightColor,
      appBar: AppBar(
        backgroundColor: AppColors.mentalBrandColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text(
          'Session ${widget.num}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.des,
                    //'Depression is a formidable adversary that affects millions of people worldwide, transcending age, gender, and socioeconomic boundaries. However, in the face of this seemingly insurmountable challenge, individuals can embark on a journey of resilience and self-discovery to overcome depression and reclaim their lives. This article explores the multifaceted aspects of overcoming depression, offering insights and strategies for those navigating this challenging terrain.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textDirection: TextDirection.ltr,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

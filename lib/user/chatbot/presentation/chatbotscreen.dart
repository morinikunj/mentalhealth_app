import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/chatbot/presentation/chatMessagewidget.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:custom_clippers/custom_clippers.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<Chat> conversation = [];
  TextEditingController send = TextEditingController();

  late OpenAI openAI;
  final api = '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';

  @override
  void initState() {
    openAI = OpenAI.instance.build(token: api);
    // TODO: implement initState
    super.initState();
    conversation.add(Chat('Hello, How can I help you?', false));
  }

  void sendMsg() async {
    var text = send.text;
    if (text.trim().isEmpty) {
      return;
    }

    setState(() {
      conversation.add(Chat(text, true));
    });

    var response = await openAI.onCompletion(
        request: CompleteText(prompt: text, model: TextBabbage001Model()));

    if (response != null && response.choices.isNotEmpty) {
      setState(() {
        conversation.add(Chat(response.choices.last.text, false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mentalBrandColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/chatbotprofile.jpg'),
              ),
            ),
            SizedBox(
              width: 18,
            ),
            Column(
              children: [
                Text(
                  'Mindly',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 170,
            ),
            Text(
              '24/7',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: conversation.length,
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 80),
          itemBuilder: (context, index) {
            var convo = conversation[index];
            return convo.amsender
                ? ChatsendMessage(msg: convo.text)
                : ChatRecievemsg(msg: convo.text);
          }),
      bottomSheet: Container(
        height: 65,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.mentalBrandColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              padding: EdgeInsets.only(top: 5, left: 20),
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                controller: send,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your queries here...'),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                sendMsg();
                send.clear();
              },
              child: Container(
                height: 50,
                width: 60,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: AppColors.mentalBrandColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chat {
  String text;
  bool amsender;
  Chat(this.text, this.amsender);
}

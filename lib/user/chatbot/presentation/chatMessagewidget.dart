import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

class ChatsendMessage extends StatelessWidget {
  var msg;
  ChatsendMessage({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ClipPath(
        clipper: LowerNipMessageClipper(MessageType.send),
        child: Container(
          margin: EdgeInsets.only(bottom: 2, top: 2),
          padding: EdgeInsets.only(left: 15, top: 8, bottom: 12, right: 20),
          decoration: BoxDecoration(
            color: AppColors.mentalBrandColor,
          ),
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatRecievemsg extends StatelessWidget {
   var msg;
  ChatRecievemsg({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    if (msg != null) {
      return Container(
        margin: EdgeInsets.only(top: 2, bottom: 2),
        padding: EdgeInsets.only(right: 50),
        child: ClipPath(
          clipper: UpperNipMessageClipper(MessageType.receive),
          child: Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(left: 20,top: 5, bottom: 8, right: 15),
            decoration: BoxDecoration(
              color: Color(0xFFE1E1E2),
            ),
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}

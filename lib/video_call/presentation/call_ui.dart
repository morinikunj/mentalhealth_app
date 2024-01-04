import 'package:flutter/material.dart';
import 'package:mentalhealth_app/experts/auth/authservice.dart';
import 'package:mentalhealth_app/video_call/constant.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: CallDetails.AppID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: CallDetails.AppSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: AuthServices.user!.uid,
      userName: AuthServices.user!.displayName!,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall() 
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Notify(),
                Divider(height: 25,),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          height: 40,
          width: 40,
          child: Icon(
            Icons.notifications,
            color: Colors.deepPurple,
          ),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            'Your appointment is canceled by doctor fjjc jjchhh dhhhdhh hhhdh',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              // fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

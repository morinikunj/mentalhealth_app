import 'package:flutter/material.dart';
import 'package:mentalhealth_app/user/authentication/application/auth_servieces.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/authentication/register/model.dart';
import 'package:mentalhealth_app/user/resources/app_colors.dart';

void showAlertBox(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text(
        'Logout',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            AuthServices.Logout(context);
          },
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

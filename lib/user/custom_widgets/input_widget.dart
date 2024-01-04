import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final TextEditingController? data;
  final String? errortext;
  final bool password;
  final formkey;

  Input(
      {super.key,
      required this.label,
      this.data,
      this.errortext,
      this.formkey,
      this.password = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: TextFormField(
        key: formkey,
        obscureText: password,
        validator: (value) {
          if (value!.isEmpty) {
            return errortext;
          }
          return null;
        },
        controller: data,
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

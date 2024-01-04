import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final data;
  final formkey;
  final label;
  final secure;
  InputField({super.key, this.data, this.formkey, this.label, this.secure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secure,
      controller: data,
      key: formkey,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter ${label}';
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter ${label}',
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

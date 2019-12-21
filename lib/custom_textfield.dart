import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  const CustomTextfield(
    {@required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: text,
        )
      );
  }
}
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const CustomTextfield(
    {@required this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: text,
        )
      );
  }
}
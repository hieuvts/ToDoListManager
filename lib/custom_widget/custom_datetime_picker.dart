import 'package:flutter/material.dart';

class CustomDatetimePicker extends StatelessWidget {
  
  final VoidCallback onPressed;
  final IconData icon;
  final String str;
  const CustomDatetimePicker({
    @required this.onPressed,
    @required this.icon,
    @required this.str
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: onPressed,
          child: Icon(icon),
        ),
        Text(
          str,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }


  //
}
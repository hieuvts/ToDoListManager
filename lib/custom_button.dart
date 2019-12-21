import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;

  const CustomButton({
    @required this.onPressed,
    @required this.buttonText,
    this.textColor,
    this.buttonColor
  });



  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 16)),
      shape: RoundedRectangleBorder(
        //side: BorderSide(color: Theme.of(context).accentColor),
        borderRadius: BorderRadius.circular(8)),
      color: buttonColor,
      textColor: textColor,
      padding: const EdgeInsets.all(15),
    );
  }
}

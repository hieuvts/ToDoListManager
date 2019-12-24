import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;
  const CustomActionButton({
    @required this.onClose,
    @required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomButton(
                onPressed: onClose,
                buttonText: "Huỷ",
                buttonColor: Colors.brown[50],
              ),

              CustomButton(
                onPressed: onSave,
                buttonText: "Lưu",
                buttonColor: Colors.red[300],
              )
            ],
          );
  }
}
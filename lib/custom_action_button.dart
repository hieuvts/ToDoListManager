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
                buttonText: "Cancel",
                buttonColor: Colors.brown[100],
              ),

              CustomButton(
                onPressed: onSave,
                buttonText: "Save",
                buttonColor: Colors.red[300],
              )
            ],
          );
  }
}
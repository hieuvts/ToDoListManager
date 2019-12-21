import 'package:flutter/material.dart';
import 'package:todolistapp/custom_button.dart';
import 'package:todolistapp/custom_textfield.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text("Add aaaa new task",
                  style: TextStyle(
                    fontSize: 32,
                  ))),
          CustomTextfield(text: "Input a new task",),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonText: "Cancel",
                buttonColor: Colors.brown[100],
              ),

              CustomButton(
                onPressed: () {},
                buttonText: "Save",
                buttonColor: Colors.red[300],
              )
            ],
          )
        ],
      ),
    );
  }
}

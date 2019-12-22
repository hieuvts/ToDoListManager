import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/custom_button.dart';
import 'package:todolistapp/custom_action_button.dart';
import 'package:todolistapp/custom_textfield.dart';

import '../custom_datetime_picker.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //String pickedDate = 'Pick a date';
  DateTime pickedDate = new DateTime.now();
  Future _pickDate() async {
    DateTime datepicker = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepicker != null)
      setState(() {
        pickedDate = datepicker;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text("Add a new task",
                  style: TextStyle(
                    fontSize: 32,
                  ))),
          CustomTextfield(
            text: "Input a new task",
          ),
          CustomDatetimePicker(
            onPressed: _pickDate,
            icon: Icons.date_range,
            str: new DateFormat("dd-MM-yyyy").format(pickedDate),
          ),
          //CustomDatetimePicker(onPressed: _pickTime, icon: Icons.access_time, str: pickedTime,),
          CustomActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {},
          )
        ],
      ),
    );
  }
}

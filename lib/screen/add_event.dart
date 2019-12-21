import 'package:flutter/material.dart';
import 'package:todolistapp/custom_textfield.dart';

import '../custom_button.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String pickedDate = 'Pick a date';
  String pickedTime = 'Pick a time';

  Future _pickDate() async {
    DateTime datepicker = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepicker!=null) setState(() {
      pickedDate = datepicker.toString();
    });
  }

  Future _pickTime() async{
    TimeOfDay timepicker = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (timepicker!=null) setState(() {
      pickedTime = timepicker.toString();
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
              child: Text("Add new event",
                  style: TextStyle(
                    fontSize: 32,
                  ))),
          CustomTextfield(
            text: "Enter event title!",
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextfield(
            text: "Enter event description",
          ),
          SizedBox(
            height: 10,
          ),
          _dateTimePicker(Icons.date_range, _pickDate, pickedDate),
          _dateTimePicker(Icons.access_time, _pickTime, pickedTime),
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

  Widget _dateTimePicker(IconData icon, VoidCallback onPressed, String str) {
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
  
}

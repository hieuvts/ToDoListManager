import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/custom_widget/custom_action_button.dart';
import 'package:todolistapp/custom_widget/custom_datetime_picker.dart';
import 'package:todolistapp/custom_widget/custom_textfield.dart';
import 'package:todolistapp/model/database.dart';


class UpdateEvent extends StatefulWidget {
  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  DateTime pickedDate = new DateTime.now();
  TimeOfDay pickedTime = new TimeOfDay.now();

  final _enteredTitle = TextEditingController();
  final _enteredDescription = TextEditingController();

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

  Future _pickTime() async {
    TimeOfDay timepicker = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (timepicker != null)
      setState(() {
        pickedTime = timepicker;
      });
  }

  @override
  Widget build(BuildContext context) {
    _enteredDescription.clear();
    _enteredTitle.clear();
    var provider = Provider.of<Database>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text("Update event",
                  style: TextStyle(
                    fontSize: 32,
                  ))),
          CustomDatetimePicker(
            onPressed: _pickDate,
            icon: Icons.date_range,
            str: new DateFormat("dd-MM-yyyy").format(pickedDate),
          ),
          SizedBox(
            height: 30,
          ),
          CustomTextfield(
            text: "Enter event title!",
            controller: _enteredTitle,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextfield(
            text: "Enter event description",
            controller: _enteredDescription,
          ),
          SizedBox(
            height: 10,
          ),

          // CustomDatetimePicker(
          //   onPressed: _pickTime,
          //   icon: Icons.access_time,
          //   str: TimeOfDay.now().toString(),
          // ),
          CustomActionButton(
            onClose: () {
              Navigator.of(context).pop();
            },
            onSave: () {
//Xu li luu thong tin
              if (_enteredTitle.text == "" && _enteredTitle.text == "") {
                //In thong tin loi ra Terminal
                print("No data");
              } else {
                provider
                    .updateTodoEntries(
                        _enteredTitle.text, _enteredDescription.text, 1)
                    .whenComplete(() => Navigator.of(context).pop());

                print("Event data updated");
              }
            },
          ),
        ],
      ),
    );
  }
}

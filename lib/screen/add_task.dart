import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/custom_button.dart';
import 'package:todolistapp/custom_action_button.dart';
import 'package:todolistapp/custom_textfield.dart';
import 'package:todolistapp/model/database.dart';

import '../custom_datetime_picker.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //String pickedDate = 'Pick a date';

  final _enteredText = TextEditingController();

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
    _enteredText.clear();
    var provider = Provider.of<Database>(context);
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
          CustomDatetimePicker(
            onPressed: _pickDate,
            icon: Icons.date_range,
            str: new DateFormat("dd-MM-yyyy").format(pickedDate),
          ),
          SizedBox(height: 30,),
          CustomTextfield(
            text: "Input a new task",
            controller: _enteredText,
          ),

          //CustomDatetimePicker(onPressed: _pickTime, icon: Icons.access_time, str: pickedTime,),
          CustomActionButton(
            onClose: () {
              //Khi nhan nut close thi dong Widget
              Navigator.of(context).pop();
            },
            onSave: () {
              //Xu li luu thong tin
              if (_enteredText.text == "") {
                //In thong tin loi ra Terminal
                print("No data");
              } else {
                provider
                    .insertTodoEntries(new TodoData(
                      id: null,
                      date: pickedDate,
                      task: _enteredText.text,
                      time: DateTime.now(),
                      //Mac dinh khi khoi tao Task chua duoc hoan thanh
                      isFinish: false,
                      description: "",
                      todoType: TodoType.TYPE_TASK.index,
                    ))
                    .whenComplete(() => Navigator.of(context).pop());

                print("Task data saved");
              }
            },
          )
        ],
      ),
    );
  }
}

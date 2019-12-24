import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todolistapp/custom_widget/custom_action_button.dart';
import 'package:todolistapp/custom_widget/custom_datetime_picker.dart';
import 'package:todolistapp/custom_widget/custom_textfield.dart';
import 'package:todolistapp/model/database.dart';

import '../custom_widget/custom_button.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
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
              child: Text("Thêm sự kiện mới",
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
            text: "Tiêu đề",
            controller: _enteredTitle,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextfield(
            text: "Nội dung",
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
              if (_enteredTitle.text == "") {
                //In thong tin loi ra Terminal
                print("No data");
              } else {
                provider
                    .insertTodoEntries(new TodoData(
                      id: null,
                      date: pickedDate,
                      task: _enteredTitle.text,
                      time: DateTime.now(),
                      //Mac dinh khi khoi tao Task chua duoc hoan thanh
                      isFinish: false,
                      description: _enteredDescription.text,
                      todoType: TodoType.TYPE_EVENT.index,
                    ))
                    .whenComplete(() => Navigator.of(context).pop());

                print("Event data saved");
                
                Toast.show("Đã lưu!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              }
            },
          ),
        ],
      ),
    );
  }
}

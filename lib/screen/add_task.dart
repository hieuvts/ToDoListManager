import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/custom_widget/custom_action_button.dart';
import 'package:todolistapp/custom_widget/custom_textfield.dart';
import 'package:todolistapp/model/database.dart';
import 'package:toast/toast.dart';
import '../custom_widget/custom_datetime_picker.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //String pickedDate = 'Pick a date';

  final _enteredText = TextEditingController();

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
              child: Text("Thêm nhiệm vụ mới",
                  style: TextStyle(
                    fontSize: 32,
                  ))),
          SizedBox(
            height: 30,
          ),
          CustomTextfield(
            text: "Việc cần làm",
            controller: _enteredText,
          ),
          SizedBox(
            height: 10,
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
                      date: DateTime.now(),
                      task: "",
                      time: DateTime.now(),
                      //Mac dinh khi khoi tao Task chua duoc hoan thanh
                      isFinish: false,
                      //Mục này sử dụng cho event
                      description: _enteredText.text,
                      todoType: TodoType.TYPE_TASK.index,
                    ))
                    .whenComplete(() => Navigator.of(context).pop());

                print("Task data saved");
                Toast.show("Đã lưu!", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todolistapp/custom_widget/custom_action_button.dart';
import 'package:todolistapp/custom_widget/custom_button.dart';
import 'package:todolistapp/custom_widget/custom_textfield.dart';
import 'package:todolistapp/model/database.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Database provider;
  final _enteredText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);

    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_TASK.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return _dataList[index].isFinish
                        ? _taskComplete(_dataList[index])
                        : _taskUncomplete(_dataList[index]);
                  },
                );
        },
      ),
    );
  }

  Widget _taskUncomplete(TodoData data) {
    _enteredText.clear();
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Cập nhật thông tin",
                          style: TextStyle(
                              fontFamily: "helveticaneue", fontSize: 30)),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                        text: "Nhập nội dung mới",
                        controller: _enteredText,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomActionButton(
                        onClose: () {
                          Navigator.of(context).pop();
                        },
                        onSave: () {
                          //Xu li luu thong tin
                          if (_enteredText.text == "") {
                            //In thong tin loi ra Terminal
                            print("No data");
                          } else {
                            provider
                                .updateTodoEntries(
                                    "", _enteredText.text, data.id)
                                .whenComplete(
                                    () => Navigator.of(context).pop());

                            print("Task updated");

                            Toast.show("Đã cập nhật!", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Đã hoàn thành?",
                          style: TextStyle(
                              fontFamily: "helveticaneue", fontSize: 30)),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Task: " + data.description,
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: "Đã hoàn thành",
                        onPressed: () {
                          provider
                              .completeTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        buttonColor: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_unchecked,
              color: Theme.of(context).accentColor,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(data.description)
          ],
        ),
      ),
    );
  }

  Widget _taskComplete(TodoData data) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Xoá nhiệm vụ?",
                          style: TextStyle(
                              fontFamily: "helveticaneue", fontSize: 30)),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Task: " + data.description,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: "Xoá?",
                        onPressed: () {
                          provider
                              .deleteTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        buttonColor: Theme.of(context).accentColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.radio_button_checked,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 28,
              ),
              Text(
                data.description,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

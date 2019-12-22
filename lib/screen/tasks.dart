import 'package:flutter/material.dart';
import 'package:todolistapp/custom_button.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class Task {
  //Khai bao final de dung Const Constructor
  final String taskName;
  final bool isFinished;
  const Task(this.taskName, this.isFinished);
}

final List<Task> _taskList = [
  new Task("Wake up early", false),
  new Task("Take breakfast", false),
  new Task("Go to schollllsadasdadas", false),
  new Task("Do something!", false),
  new Task("Go swimming", true),
  new Task("Play game", true),
  new Task("Go Go GOOO", true),
];

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return _taskList[index].isFinished
            ? _taskCompletedList(_taskList[index])
            : _taskUncompletedList(_taskList[index]);
      },
    );
  }

  Widget _taskUncompletedList(Task taskInfo) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "PatrickHand",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    taskInfo.taskName,
                    style: TextStyle(
                      fontFamily: "helveticaneue",
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                      fontFamily: "helveticaneue",
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Confirm button
                  CustomButton(
                    buttonText: "Confirm",
                    textColor: Colors.white,
                    buttonColor: Colors.redAccent,
                    onPressed: () {
                      //Confirm button
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Delete this task?",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "PatrickHand",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    taskInfo.taskName,
                    style: TextStyle(
                      fontFamily: "helveticaneue",
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                      fontFamily: "helveticaneue",
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Confirm button
                  CustomButton(
                    buttonText: "Delete!",
                    textColor: Colors.white,
                    buttonColor: Colors.redAccent,
                    onPressed: () {
                      //Confirm button
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ]),
                child: Icon(
                  Icons.radio_button_unchecked,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                taskInfo.taskName,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "helveticaneue",
                ),
              ),
            ],
          )),
    );
  }

  Widget _taskCompletedList(Task taskInfo) {
    return InkWell(
      onTap: () {
        
      },
      onLongPress: () {
        //Do something later
      },
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(80, 245, 91, 91),
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                ]),
                child: Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                taskInfo.taskName,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "helveticaneue",
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )),
    );
  }
}

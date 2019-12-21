import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}
class Task{
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
      itemBuilder: (context, index){
        return _taskList[index].isFinished 
        ? _taskCompletedList(_taskList[index].taskName) 
        : _taskUncompletedList(_taskList[index].taskName);
      },
    );
  }

  Widget _taskUncompletedList(String task) {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
              Icon(Icons.radio_button_unchecked,
                    color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 10,),
              Text(task,
              style: TextStyle(fontSize: 15, fontFamily: "helveticaneue", ),
              ),
            ],
          )
    );
  }
  Widget _taskCompletedList(String task) {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
              Icon(Icons.radio_button_checked,
                    color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 10,),
              Text(task,
              style: TextStyle(fontSize: 15, fontFamily: "helveticaneue", fontStyle: FontStyle.italic,),
              ),
            ],
          )
    );
  }
}

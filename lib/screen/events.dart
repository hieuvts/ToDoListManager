import 'package:flutter/material.dart';

class EventScene extends StatefulWidget {
  @override
  _EventSceneState createState() => _EventSceneState();
}

class _EventSceneState extends State<EventScene> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _eventList.length,
        padding: EdgeInsets.only(left: 10),
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                            color: Color(0x20000000),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                  ]
                ),
                child: Icon(_eventList[index].isFinished 
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                  size: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Container(width: 80, child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(_eventList[index].time, style: TextStyle(fontSize: 17,),),
              )),
              //Cho vao Expanded de box bao quanh content rong qua
              Expanded(
                //Tao khoang cach quanh box
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x20000000),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _eventList[index].desc,
                          style: TextStyle(
                              fontSize: 30, fontFamily: "helveticaneue"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _eventList[index].task,
                          style: TextStyle(
                              fontSize: 20, fontFamily: "helveticaneue"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
class Event{
  final String time;
  final String task;
  final String desc;
  final bool isFinished;
  const Event(this.time, this.task, this.desc, this.isFinished);

}
final List<Event> _eventList = [
  new Event("8:00", "Go out", "Meet friends", true),
  new Event("9:00", "Go back home", "Cooking", true),
  new Event("13:00", "Get to school", "Study time", false),
  new Event("17:00", "Go back home", "Take a shower", false),
];
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/custom_widget/custom_button.dart';
import 'package:todolistapp/model/database.dart';
import 'package:todolistapp/screen/update_event.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Database provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Database>(context);

    return StreamProvider.value(
      value: provider.getTodoByType(TodoType.TYPE_EVENT.index),
      child: Consumer<List<TodoData>>(
        builder: (context, _dataList, child) {
          return _dataList == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _dataList.length,
                  padding: EdgeInsets.only(left: 10),
                  itemBuilder: (context, index) {
                    return _dataList[index].isFinish
                        ? _eventComplete(_dataList[index])
                        : _eventUncomplete(_dataList[index]);
                  });
        },
      ),
    );
  }

  Widget _eventUncomplete(TodoData data) {
    return InkWell(
      onLongPress: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  child: UpdateEvent(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))));
            });
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                  padding: const EdgeInsets.all(10),
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
                      Text("Event: " + data.task,
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                          "Thời gian: " +
                              new DateFormat("dd-MM-yyyy").format(data.date),
                          style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: "Đã hoàn thành",
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          provider
                              .completeTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                      )
                    ],
                  )),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            //Container chua Icon
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ]),
              child: Icon(
                Icons.radio_button_unchecked,
                size: 20,
                color: Colors.red,
              ),
            ),
            //Container chua o hien thi thoi gian.
            Container(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Thời gian: " +
                        new DateFormat("dd-MM-yyyy").format(data.date),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )),
            //Cho vao Expanded de box bao quanh content rong
            Expanded(
              //Tao khoang cach quanh box
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                //Hien thi noi dung event
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //Text hien thi Tieu de cua Event - Event Title
                      Text(
                        //event title
                        data.task,
                        style: TextStyle(
                            fontSize: 30, fontFamily: "helveticaneue"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //event description
                        data.description,
                        style: TextStyle(
                            fontSize: 20, fontFamily: "helveticaneue"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//
//
  Widget _eventComplete(TodoData data) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Xoá sự kiện này?",
                          style: TextStyle(
                              fontFamily: "helveticaneue", fontSize: 30)),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Event: " + data.task,
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        buttonText: "Xoá?",
                        buttonColor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          provider
                              .deleteTodoEntries(data.id)
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                      )
                    ],
                  )),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            //Container chua Icon
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0x20000000),
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ]),
              child: Icon(
                Icons.radio_button_checked,
                size: 20,
                color: Colors.red,
              ),
            ),
            //Container chua o hien thi thoi gian.
            Container(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Thời gian: " +
                        new DateFormat("dd-MM-yyyy").format(data.date),
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )),
            //Cho vao Expanded de box bao quanh content rong
            Expanded(
              //Tao khoang cach quanh box
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                //Hien thi noi dung event
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //Text hien thi Tieu de cua Event - Event Title
                      Text(
                        //event title
                        data.task,
                        style: TextStyle(
                            fontSize: 30, fontFamily: "helveticaneue"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //event description
                        data.description,
                        style: TextStyle(
                            fontSize: 20, fontFamily: "helveticaneue"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

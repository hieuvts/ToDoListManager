import 'package:flutter/material.dart';
import 'package:todolistapp/custom_button.dart';
import 'package:todolistapp/screen/add_event.dart';
import 'package:todolistapp/screen/add_task.dart';
import 'package:todolistapp/screen/events.dart';
import 'package:todolistapp/screen/tasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "OpenSansCondensed-Bold",
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
                  _mainContent(context), 
                  Container(
                    height: 25, 
                    color: Theme.of(context).accentColor,
                    //child: Text("To do list"),
                    ),
                  Positioned(
                    //Khoang cach tu mep phai den Text
                    right: 10,
                    child: Text(
                    "6",
                    style: TextStyle(fontSize:200, color: Color(0x10000000)),
                    ),
                  ),
                ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              //Chi duoc dung nut BACK de thoat Dialog
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: AddEvent(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                    );
              }
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        //Float Action Button Phia tren thanh bottomNaviBar
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //Chen space vao giua cac button
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }

  Column _mainContent(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Monday",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, fontFamily: "PatrickHand",),
            ),
          ),
          //Nut Task
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _button(context),
          ),
          Expanded(
            //child: TaskScreen(),
            child: EventScene(),
          )
        ],
      );
  }

  
  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButton(
            onPressed: (){},
            textColor: Colors.white, 
            buttonColor: Theme.of(context).accentColor,
            buttonText: "Task", )
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: CustomButton(
            onPressed: (){},
            textColor: Theme.of(context).accentColor, 
            buttonColor:  Colors.white,
            buttonText: "Events",
        ),
        ),
      ],
    );
  }

  
}

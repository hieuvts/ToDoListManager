import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/custom_widget/custom_button.dart';
import 'package:todolistapp/model/database.dart';
import 'package:todolistapp/screen/add_event.dart';
import 'package:todolistapp/screen/add_task.dart';
import 'package:todolistapp/screen/events.dart';
import 'package:todolistapp/screen/tasks.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Ẩn thanh status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Database>(create: (_) => Database()),
        ],
        child: MaterialApp(
          title: 'Tasks and Events manager',
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: "OpenSansCondensed-Bold",
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  //Do _pageController.page tra ve kieu double
  //Mac dinh luc chay app se hien thi TaskPage <=> 0
  double _currentPage = 0;
  DateTime _currentDateTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
      });
    });
    return Scaffold(
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(30.0), //Chieu cao cua AppBar
        //     child: AppBar(
        //       title: new Text("Tasks and Events manager"),
        //     )),
        body: Stack(
          children: <Widget>[
            _mainContent(context),
            // Container(
            //   height: 25,
            //   color: Theme.of(context).accentColor,
            //   //child: Text("To do list"),
            // ),
            Positioned(
              //Khoang cach tu mep phai den Text hien so ngay
              right: 10,
              child: Text(
                new DateFormat("dd").format(_currentDateTime),
                style: TextStyle(fontSize: 90, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      child: _currentPage == 0 ? AddTask() : AddEvent(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))));
                });
          },
          child: Icon(Icons.add),
          tooltip: "Thêm mới",
          backgroundColor: Colors.red[600],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //Chen space vao giua cac button
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "To-do List\nVersion 1.0.0",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))));
                      });
                },
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
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            //https://api.flutter.dev/flutter/intl/DateFormat-class.html
            new DateFormat("EEEEE").format(_currentDateTime),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              fontFamily: "PatrickHand",
            ),
          ),
        ),
        //Nut Task?Event
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          //Extract widget ra ngoài
          child: _button(context),
        ),
        //Tao duong phan chia Button va ListView
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 2,
        ),
        Expanded(
          //Tao 1 pageview vuot trai/phai de chuyen Screen
          child: PageView(
            controller: _pageController,
            children: <Widget>[TaskScreen(), EventScreen()],
          ),
        )
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          //Neu page hien tai la TaskPage (0) thi button mau do, chu mau trang
          textColor: _currentPage == 0 ? Colors.white : Colors.red,
          buttonColor: _currentPage == 0 ? Colors.red : Colors.white,
          buttonText: "Tasks",
        )),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: CustomButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            textColor: _currentPage == 0 ? Colors.red : Colors.white,
            buttonColor: _currentPage == 0 ? Colors.white : Colors.red,
            buttonText: "Events",
          ),
        ),
      ],
    );
  }
}

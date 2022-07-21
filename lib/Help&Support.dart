import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trivy/Contact.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';

class Help extends StatefulWidget {
  static const String id = 'Help';
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
        },
        child: SafeArea(
          child: Center(
            child: GestureDetector(
              child: GestureDetector(
                onPanStart: (var on) {
                  on != null ? ZoomDrawer.of(context).toggle() : null;
                },
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: AppColor.c3,
                    foregroundColor: AppColor.c2,
                    elevation: 10.0,
                    child: Icon(Icons.question_answer),
                    onPressed: () {
                      Navigator.pushNamed(context, Contact.id);
                    },
                  ),
                  backgroundColor: AppColor.c1,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Color(0xffeeeeee),
                    ),
                    leading: InkWell(
                      onTap: () => ZoomDrawer.of(context).toggle(),
                      child: Icon(Icons.menu),
                    ),
                    title: Center(child: Text('FAQs')),
                    // actions: <Widget>[
                    //   IconButton(
                    //     icon: Icon(Icons.settings),
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, Settings.id);
                    //     },
                    //   )
                    // ],
                    elevation: 0,
                    backgroundColor: Color(0xff232931),
                    brightness: Brightness.dark,
                    textTheme: TextTheme(
                      // ignore: deprecated_member_use
                      title: TextStyle(
                        color: AppColor.c4,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // drawer: Drawerr(),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''Better your rating more the benefits. More the documents better the rating.''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      'Why should one upload their documents?',
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''The Website is currently active at trivytech.in''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      'Is there a Website?',
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''Anything under law is permitted.''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      'Do airlines allow this?',
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''Always tell the truth! Simply state that you're flying as an on-board courier with Trivy.''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      "What if I'm asked by an airline employee or government official about my containers?",
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''Each traveler receives a digital manifest that includes photos and descriptions of every item.''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      "How do I know what I'm transporting",
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 25.0,
                                  right: 20.0,
                                  left: 20.0),
                              child: Column(
                                children: <Widget>[
                                  ExpansionTile(
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(35.0),
                                          child: Text(
                                            '''After the completion of sharers payment chat-up system is activated.''',
                                            style: TextStyle(
                                              color: AppColor.c4,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    title: Text(
                                      'How to talk with the courier(Earner)?',
                                      style: TextStyle(
                                        color: AppColor.c4,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Icon(
                                      Icons.question_answer,
                                      color: AppColor.c4,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c3])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

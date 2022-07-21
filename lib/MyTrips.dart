import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trivy/Match.dart';
import 'package:trivy/Share.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

import 'Share.dart';

bool showSpinner = true;

final _earnerFireStore =
    firestore.FirebaseFirestore.instance.collection("Earner");

final _sharerFireStore =
    firestore.FirebaseFirestore.instance.collection("Sharer");

class MyTrips extends StatefulWidget {
  static const String id = 'MyTrips';
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  bool isInit = true;

  var dataToShow = [];

  List earnerList = [];
  List sharerList = [];

  @override
  void initState() {
    print(typeOfUser.toString());
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      await earnerData();
      // await sharerData();
      //print(earnerList);
      //print(sharerList);
      isInit = false;
      dataToShow = earnerList;
      print(dataToShow);
      setState(() {});
    }

    super.didChangeDependencies();
  }

  earnerData() async {
    firestore.QuerySnapshot querySnapshot = await _earnerFireStore
        .where("uid", isEqualTo: ServiceApp.auth.currentUser.uid)
        .orderBy('date', descending: true)
        .get()
        .catchError((onError) => print("Error----$onError"));
    ;
    setState(() {
      showSpinner = false;
      querySnapshot.docs.forEach((element) async {
        earnerList.add(element);
      });
    });
  }

  sharerData() async {
    firestore.QuerySnapshot querySnapshot = await _sharerFireStore
        .where("uid", isEqualTo: ServiceApp.auth.currentUser.uid)
        .orderBy('date', descending: true)
        .get()
        .catchError((onError) => print("Error----$onError"));
    setState(() {
      showSpinner = false;
      querySnapshot.docs.forEach((element) async {
        sharerList.add(element);
      });
    });
  }

  bool isSwitched = false;
  var textValue = 'Trips as Earner';
  var matchtype = 'Earner';
  void toggleSwitch(bool value) {
    dataToShow.clear();
    if (isSwitched == false) {
      setState(() {
        sharerData();

        dataToShow = sharerList;
        isSwitched = true;
        textValue = 'Trips as Sharer';
        matchtype = 'sharer';
      });

      print('Switch Button is ON');
    } else {
      setState(() {
        earnerData();

        dataToShow = earnerList;
        isSwitched = false;
        textValue = 'Trips as Earner';
        matchtype = 'earner';
      });

      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
        },
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: GestureDetector(
              child: GestureDetector(
                onPanStart: (var on) {
                  on != null ? ZoomDrawer.of(context).toggle() : null;
                },
                child: Scaffold(
                  backgroundColor: AppColor.c1,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: AppColor.c1,
                    ),
                    leading: InkWell(
                      onTap: () => ZoomDrawer.of(context).toggle(),
                      child: Icon(Icons.menu),
                    ),
                    title: Center(child: Text('My Trips')),
                    // actions: <Widget>[
                    //   IconButton(
                    //     icon: Icon(Icons.settings),
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, Settings.id);
                    //     },
                    //   )
                    // ],
                    elevation: 0,
                    backgroundColor: AppColor.c6,
                    brightness: Brightness.dark,
                    textTheme: TextTheme(
                        title: TextStyle(
                      color: AppColor.c2,
                      fontSize: 20,
                    )),
                  ),
                  // drawer: Drawerr(),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            Switch(
                              onChanged: toggleSwitch,
                              value: isSwitched,
                              activeColor: Colors.blue,
                              activeTrackColor: Colors.yellow,
                              inactiveThumbColor: Colors.redAccent,
                              inactiveTrackColor: Colors.orange,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Center(
                                child: Text(
                                  '$textValue',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 120,
                              child: dataToShow.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.only(top: 60),
                                      child: Text(
                                        "No Trips !",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                        ),
                                      ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: dataToShow.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: detailsContainer(
                                            context,
                                            dataToShow[index]["flightnumber"] ??
                                                "",
                                            dataToShow[index]["from"] ?? "",
                                            dataToShow[index]["to"] ?? "",
                                            dataToShow[index]['date'] ?? "",
                                            dataToShow[index]['weight'] ?? "",
                                            dataToShow[index]['price'] ?? "",
                                            dataToShow[index]['name'] ?? "",
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // floatingActionButton: FloatingActionButton(
                  //   backgroundColor: AppColor.c3,
                  //   foregroundColor: AppColor.c2,
                  //   elevation: 10.0,
                  //   child: Icon(Icons.question_answer),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, Contact.id);
                  //   },
                  // ),
                ),
              ),
            ),
          ),
        ));
  }

  Container detailsContainer(
      BuildContext context, fno, from, to, date, weight, price, name) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Flight no : $fno',
                style: TextStyle(fontSize: 20, color: AppColor.c2),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'From : $from',
                    style: TextStyle(fontSize: 20, color: AppColor.c2),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: <Widget>[
                  Text(
                    'To : $to',
                    style: TextStyle(fontSize: 20, color: AppColor.c2),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Extra luggage/space: $weight',
                    style: TextStyle(fontSize: 20, color: AppColor.c2),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 50.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Find a match',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.c2,
                        ),
                      ),
                      color: AppColor.c1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Match(
                                      usertype: matchtype,
                                      weight: weight,
                                      date: date,
                                      flightNo: fno,
                                      name: name,
                                    )));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c6])),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:trivy/Drawer.dart';
// import 'package:trivy/Earn.dart';
// import 'package:trivy/Share.dart';
// import 'package:trivy/Wallet.dart';
// import 'package:trivy/loginpage.dart';
// import 'package:trivy/signup.dart';
// import 'package:trivy/TC.dart';
// import 'package:trivy/MyAccount.dart';
// import 'package:trivy/Contact.dart';
// import 'package:trivy/About.dart';
// import 'package:trivy/MyTrips.dart';
// import 'package:trivy/Help&Support.dart';
// import 'package:trivy/How.dart';
// import 'package:trivy/Profile.dart';
// import 'package:trivy/Settings.dart';
// import 'package:trivy/Match.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'Track.dart';
//
// class MyTrips extends StatefulWidget {
//   static const String id = 'MyTrips';
//   @override
//   _MyTripsState createState() => _MyTripsState();
// }
//
// class _MyTripsState extends State<MyTrips> {
//   Color AppColor.c1 = const Color(0xff232931);
//   Color AppColor.c2 = const Color(0xff393e46);
//   Color AppColor.c3 = const Color(0xff4ecca3);
//   Color AppColor.c4 = const Color(0xffeeeeee);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.c1,
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: AppColor.c4,
//           ),
//           title: Center(child: Text('My Trips')),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 Navigator.pushNamed(context, Settings.id);
//               },
//             )
//           ],
//           elevation: 0,
//           backgroundColor: AppColor.c1,
//           brightness: Brightness.dark,
//           textTheme: TextTheme(
//               title: TextStyle(
//             color: AppColor.c4,
//             fontSize: 20,
//           )),
//         ),
//         drawer: Drawerr(),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: <Widget>[
//                   detailsContainer(
//                       context, 32324, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                   detailsContainer(
//                       context, 2, 'delhi', 'indore', 'none', 15, 'none'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: AppColor.c3,
//           foregroundColor: AppColor.c2,
//           elevation: 10.0,
//           child: Icon(Icons.question_answer),
//           onPressed: () {
//             Navigator.pushNamed(context, Contact.id);
//           },
//         ),
//       ),
//     );
//   }
//
//   Container detailsContainer(
//       BuildContext context, fno, from, to, status, extra, avail) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 50.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Text(
//                   'Flight no : $fno',
//                   style: TextStyle(fontSize: 20, color: AppColor.c4),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Text(
//                       'From : $from',
//                       style: TextStyle(fontSize: 20, color: AppColor.c4),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Text(
//                       'To : $to',
//                       style: TextStyle(fontSize: 20, color: AppColor.c4),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Text(
//                       'Extra luggage/space: 6 Kg',
//                       style: TextStyle(fontSize: 20, color: AppColor.c4),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 25.0, bottom: 50.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     RaisedButton(
//                       child: Text(
//                         'Find a match',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: AppColor.c4,
//                         ),
//                       ),
//                       color: Color(0xff232931),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(80)),
//                       onPressed: () {
//                         Navigator.pushNamed(context, Match.id);
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 // Column(
//                 //   children: <Widget>[
//                 //
//                 //     RaisedButton(
//                 //       child: Text(
//                 //         'Track',
//                 //         style: TextStyle(
//                 //           fontSize: 15,
//                 //           color: AppColor.c4,
//                 //         ),
//                 //       ),
//                 //       color: AppColor.c1,
//                 //       shape: RoundedRectangleBorder(
//                 //           borderRadius: BorderRadius.circular(80)),
//                 //       onPressed: () {
//                 //       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Track()));
//                 //       },
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             ),
//           )
//         ],
//       ),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
//     );
//   }
// }

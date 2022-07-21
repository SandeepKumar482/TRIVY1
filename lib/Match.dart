import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trivy/Drawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/my_matches.dart';
import 'package:trivy/trivyTech.dart';

import 'my_matches.dart';

bool showSpinner = true;
final _earnerFireStore =
    firestore.FirebaseFirestore.instance.collection("Earner");

final _sharerFireStore =
    firestore.FirebaseFirestore.instance.collection("Sharer");
final _requestFirestore =
    firestore.FirebaseFirestore.instance.collection("Requests");

String buttonText = 'Ask To Match';

class Match extends StatefulWidget {
  static const String id = 'Match';
  String usertype;
  var weight;
  var date;
  var flightNo;
  var name;
  Match({
    this.usertype,
    this.weight,
    this.date,
    this.flightNo,
    this.name,
  });
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  bool isinit = true;

  String emptyText = "No Earner";
  var earnerList = [];
  var sharerList = [];
  var dataToShow = [];
  List args;

  earnerData() async {
    firestore.QuerySnapshot querySnapshot = await _earnerFireStore
        .where("uid", isNotEqualTo: ServiceApp.auth.currentUser.uid)
        .where("flightnumber", isEqualTo: widget.flightNo)
        .where("date", isEqualTo: widget.date.toDate())
        // .where("availability", isEqualTo: 0)
        .get();
    setState(() {
      showSpinner = false;
      querySnapshot.docs.forEach((element) {
        earnerList.add(element);
      });
    });
  }

  sharerData() async {
    firestore.QuerySnapshot querySnapshot = await _sharerFireStore
        .where("uid", isNotEqualTo: ServiceApp.auth.currentUser.uid)
        .where("date", isEqualTo: widget.date)
        .where("flightnumber", isEqualTo: widget.flightNo)
        // .where("availability", isEqualTo: 0)
        .get();
    setState(() {
      querySnapshot.docs.forEach((element) {
        sharerList.add(element);
      });
    });
  }

  @override
  void didChangeDependencies() async {
    if (isinit) {
      //  args = ModalRoute.of(context).settings.arguments as List<UserType>;
      if (widget.usertype == 'sharer') {
        print("In Sharer");
        emptyText = "No Earner!";
        await earnerData();
        dataToShow = earnerList;
        setState(() {});
        isinit = false;
      } else {
        print("In Earner");
        emptyText = "No Sharer!";
        await sharerData();
        dataToShow = sharerList;
        setState(() {});
        isinit = false;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: AppColor.c3,
            //   foregroundColor: AppColor.c2,
            //   elevation: 10.0,
            //   child: Icon(Icons.question_answer),
            //   onPressed: () {
            //     Navigator.pushNamed(context, Contact.id);
            //   },
            // ),
            backgroundColor: AppColor.c1,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Color(0xffeeeeee),
              ),
              title: Center(child: Text('Find A Sharer/Earner')),
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
            drawer: Drawerr(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  children: [
                    dataToShow.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                                child: Text("$emptyText",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20))),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height - 100,
                            child: ListView.builder(
                              itemCount: dataToShow.length,
                              itemBuilder: (context, index) {
                                return detailsContainer(
                                    context,
                                    dataToShow[index]["flightnumber"] ?? "",
                                    dataToShow[index]["from"] ?? "",
                                    dataToShow[index]["to"] ?? "",
                                    dataToShow[index]["date"] ?? "",
                                    dataToShow[index]["name"] ?? "",
                                    dataToShow[index]["weight"] ?? "",
                                    "",
                                    index);
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container detailsContainer(
    BuildContext context,
    fno,
    from,
    to,
    date,
    name,
    avail,
    trips,
    index,
  )
  // var myformat=DateFormat('d-MM, hh:mm');
  {
    var myformat = DateFormat('d-MM, hh:mm a');

    return Container(
      margin: EdgeInsets.all(10),
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person,
              ),
              Text(
                ' Passenger Details ',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.c4,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.person,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Name : $name',
                style: TextStyle(fontSize: 20, color: AppColor.c4),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Flight no : $fno',
                style: TextStyle(fontSize: 20, color: AppColor.c4),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'From : $from',
                    style: TextStyle(fontSize: 20, color: AppColor.c4),
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
                    style: TextStyle(fontSize: 20, color: AppColor.c4),
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
                    'Date & Time: ${myformat.format(date.toDate())}',
                    style: TextStyle(fontSize: 20, color: AppColor.c4),
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
                    'Extra luggage/space: $avail Kg',
                    style: TextStyle(fontSize: 20, color: AppColor.c4),
                  )
                ],
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Text(
          //       'Trips Completed : $trips',
          //       style: TextStyle(fontSize: 20, color: AppColor.c4),
          //     )
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // widget.usertype=='earner'?RaisedButton(
                //   child: Text(
                //     'View Profile',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: AppColor.c4,
                //     ),
                //   ),
                //   color: Color(0xff232931),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(80)),
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) {
                //       return ProfileMatch(dataToShow[index]["uid"]);
                //     }));
                //     //onMatch();
                //   },
                // ):null,
                // RaisedButton(
                //   child: Text(
                //     'Chat',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: AppColor.c4,
                //     ),
                //   ),
                //   color: Color(0xff232931),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(80)),
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) {
                //       return ChatScreen(dataToShow[index]["uid"]);
                //     }));
                //   },
                // ),
                RaisedButton(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.c4,
                    ),
                  ),
                  color: Color(0xff232931),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  onPressed: () async {
                    try {
                      await _requestFirestore.add({
                        'match': ServiceApp.auth.currentUser.uid,
                        'availability': 0,
                        'receiverUid': dataToShow[index]["uid"],
                        'date': date,
                        'senderUid': ServiceApp.auth.currentUser.uid,
                        "flightnumber": dataToShow[index]["flightnumber"],
                        "from": dataToShow[index]["from"],
                        "to": dataToShow[index]["to"],
                        "senderName": widget.name,
                        "receiverName": dataToShow[index]["name"],
                        "weight": widget.weight
                      });

                      setState(() {
                        buttonText = 'pending..';
                      });
                      _showToast(context);
                    } catch (e) {
                      print("Exception $e");
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [AppColor.c1, AppColor.c3],
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Keep Checking your Match Section'),
        action: SnackBarAction(
            label: 'Check',
            onPressed: () {
              Navigator.pushNamed(context, MyMatch.id);
            }),
      ),
    );
  }
}
//   onMatch() {
//     String collection;
//     if (typeOfUser == UserType.Earner) {
//       collection = "Sharer";
//     } else {
//       collection = "Earner";
//     }
// // Check the below code
//     Firestore.instance
//         .collection(collection)
//         // .where("firebaseUser.uid", isEqualTo: dataToShow['id'])
//         .where("avail", isGreaterThanOrEqualTo: dataToShow)
//         .where("price", isEqualTo: dataToShow)
//         .getDocuments()
//         .then((string) {
//       // print('Firestore response111: , ${string.documents.length}');

//       // string.documents.forEach(
//       //     (doc) => print("Firestore response222: ${doc.data.toString()}"));
//     });
//   }

// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:trivy/MyAccount.dart';
// import 'package:trivy/TC.dart';
// import 'package:trivy/loginpage.dart';
// import 'package:trivy/Earn.dart';
// import 'package:trivy/Share.dart';
// import 'package:trivy/Wallet.dart';
// import 'package:trivy/About.dart';
// import 'package:trivy/Contact.dart';
// import 'package:trivy/MyTrips.dart';
// import 'package:trivy/Help&Support.dart';
// import 'package:trivy/How.dart';
// import 'package:trivy/Profile.dart';
// import 'package:trivy/Settings.dart';
//
// class Match extends StatefulWidget {
//   static const String id = 'Match';
//   @override
//   _MatchState createState() => _MatchState();
// }
//
// class _MatchState extends State<Match> {
//   Color AppColor.c1 = const Color(0xff232931);
//   Color AppColor.c2 = const Color(0xff393e46);
//   Color AppColor.c3 = const Color(0xff4ecca3);
//   Color AppColor.c4 = const Color(0xffeeeeee);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Center(
//         child: Scaffold(
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: AppColor.c3,
//             foregroundColor: AppColor.c2,
//             elevation: 10.0,
//             child: Icon(Icons.question_answer),
//             onPressed: () {
//               Navigator.pushNamed(context, Contact.id);
//             },
//           ),
//           backgroundColor: AppColor.c1,
//           appBar: AppBar(
//             iconTheme: IconThemeData(
//               color: Color(0xffeeeeee),
//             ),
//             title: Center(child: Text('Find A Sharer/Earner')),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.settings),
//                 onPressed: () {
//                   Navigator.pushNamed(context, Settings.id);
//                 },
//               )
//             ],
//             elevation: 0,
//             backgroundColor: Color(0xff232931),
//             brightness: Brightness.dark,
//             textTheme: TextTheme(
//               title: TextStyle(
//                 color: AppColor.c4,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           drawer: Drawer(),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Column(
//                   children: <Widget>[
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                     detailsContainer(context, 32324, 'delhi', 'indore',
//                         'Pulkit Agarwal', 15, 50),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container detailsContainer(
//       BuildContext context, fno, from, to, name, avail, trips) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Icon(
//                   Icons.person,
//                 ),
//                 Text(
//                   ' Passenger Details ',
//                   style: TextStyle(
//                       fontSize: 20, color: AppColor.c4, fontWeight: FontWeight.bold),
//                 ),
//                 Icon(
//                   Icons.person,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 15, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Text(
//                   'Name : $name',
//                   style: TextStyle(fontSize: 20, color: AppColor.c4),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
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
//                 top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
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
//                 top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Text(
//                       'Extra luggage/space: $avail Kg',
//                       style: TextStyle(fontSize: 20, color: AppColor.c4),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               children: <Widget>[
//                 Text(
//                   'Trips Completed : $trips',
//                   style: TextStyle(fontSize: 20, color: AppColor.c4),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 10.0, bottom: 25.0, right: 20.0, left: 40.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 RaisedButton(
//                   child: Text(
//                     'Match',
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: AppColor.c4,
//                     ),
//                   ),
//                   color: Color(0xff232931),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(80)),
//                   onPressed: () {},
//                 ),
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

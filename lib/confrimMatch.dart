import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:trivy/trivyTech.dart';

import 'ViewProfileMatch.dart';
import 'appColor.dart';
import 'chat/chat_screen.dart';

final _confirmFirestore =
    firestore.FirebaseFirestore.instance.collection("ConfirmedRequests");

class ConfirmMatch extends StatefulWidget {
  @override
  _ConfirmMatchState createState() => _ConfirmMatchState();
}

bool showSpinner = true;

class _ConfirmMatchState extends State<ConfirmMatch> {
  var requestList = [];
  var dataToShow = [];
  requestsData(String id) async {
    firestore.QuerySnapshot querySnapshot = await _confirmFirestore
        .where(id, isEqualTo: ServiceApp.auth.currentUser.uid)
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .get();

    setState(() {
      showSpinner = false;
      querySnapshot.docs.forEach((element) {
        requestList.add(element);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    requestsData('receiverUid');
    requestsData('senderUid');
    dataToShow = requestList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var emptyText = 'No Match ';
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            dataToShow.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text(emptyText,
                            style: TextStyle(color: Colors.red, fontSize: 20))),
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
                            dataToShow[index]["senderName"] ?? "",
                            dataToShow[index]["receiverName"] ?? "",
                            dataToShow[index]["weight"] ?? "",
                            "",
                            index);
                      },
                    ),
                  ),
          ],
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
    sName,
    rName,
    avail,
    trips,
    index,
  )
  // var myformat=DateFormat('d-MM, hh:mm');
  {
    var myformat = DateFormat('d-MM, hh:mm a');
    var name = ServiceApp.auth.currentUser.displayName == rName ? sName : rName;
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
                    color: AppColor.c2,
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
                style: TextStyle(fontSize: 20, color: AppColor.c2),
              )
            ],
          ),
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
                    'Date & Time: ${myformat.format(date.toDate())}',
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
                    'Extra luggage/space: $avail Kg',
                    style: TextStyle(fontSize: 20, color: AppColor.c2),
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
                RaisedButton(
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.c4,
                    ),
                  ),
                  color: Color(0xff232931),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfileMatch(dataToShow[index]["senderUid"]);
                    }));
                  },
                ),
                RaisedButton(
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.c4,
                    ),
                  ),
                  color: Color(0xff232931),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  onPressed: () {
                    if (dataToShow[index]["receiverUid"] ==
                        ServiceApp.auth.currentUser.uid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(dataToShow[index]["senderUid"])));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  dataToShow[index]["receiverUid"])));
                    }
                  },
                ),
                // RaisedButton(
                //   child: Text(
                //     'Confirm Match',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: AppColor.c4,
                //     ),
                //   ),
                //   color: Color(0xff232931),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(80)),
                //   onPressed: () async {
                //     var ofDid;
                //     final firestore.QuerySnapshot uQuery =
                //         await _confirmFirestore
                //             .where('senderUid',
                //                 isEqualTo: dataToShow[index]['senderUid'])
                //             .get();
                //     uQuery.docs.forEach((element) {
                //       ofDid = element.documentID;
                //     });
                //     await _confirmFirestore.doc(ofDid).update({
                //       'match': dataToShow[index]['senderUid'] +
                //           "-" +
                //           ServiceApp.auth.currentUser.uid
                //     });
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [AppColor.c1, AppColor.c6],
        ),
      ),
    );
  }
}

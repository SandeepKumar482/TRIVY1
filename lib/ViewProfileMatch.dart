import 'dart:ui';

//import 'package:trivy/api/firebase_api.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'edit.dart';

import 'package:trivy/Contact.dart';
import 'package:trivy/Drawer.dart';
import 'package:trivy/MyTrips.dart';
//import 'package:trivy/editIntrest.dart';
//import 'package:trivy/admin.dart';
import 'package:trivy/trivyTech.dart';

import 'appColor.dart';

final _earnerFireStore =
    firestore.FirebaseFirestore.instance.collection("Earner");

final _sharerFireStore =
    firestore.FirebaseFirestore.instance.collection("Sharer");

class ProfileMatch extends StatefulWidget {
  ProfileMatch(this.uid);
  final String uid;

  static const String id = 'Profile';
  @override
  _ProfileMatchState createState() => _ProfileMatchState();
}

int count = 0;

bool _isSelected = false;

UploadTask task;
SharedPreferences sharedPreferences;
String name = "";
String email = "";
String phone = "";
String dob = "";
String coverurl = "";
String profileurl = "";

class _ProfileMatchState extends State<ProfileMatch> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    alldetails();
    allTrips();
    getSelectedList();

    super.initState();
  }

  String trips() {
    return count.toString();
  }

  allTrips() async {
    count = 0;
    firestore.QuerySnapshot querySnapshot = await _earnerFireStore
        .where("uid", isEqualTo: ServiceApp.auth.currentUser.uid)
        .get();
    firestore.QuerySnapshot querySnapshot2 = await _sharerFireStore
        .where("uid", isEqualTo: ServiceApp.auth.currentUser.uid)
        .get();
    setState(() {
      querySnapshot.docs.forEach((element) async {
        // earnerList.add(element);
        count += 1;
      });
      querySnapshot2.docs.forEach((element) async {
        //  sharerList.add(element);
        count += 1;
      });
    });
  }

  getSelectedList() async {
    setState(() {
      firestore.FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get()
          .then((dataSnapshot) async {
        try {
          ServiceApp.selectedChoicesTravler =
              await dataSnapshot.get("interests");
        } catch (e) {
          ServiceApp.selectedChoicesTravler = [];
          print(e);
        }
      });
    });
  }

  alldetails() async {
    setState(() {
      firestore.FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get()
          .then((dataSnapshot) async {
        name = await dataSnapshot.get(ServiceApp.userName);
        email = await dataSnapshot.get(ServiceApp.userEmail);
        phone = await dataSnapshot.get(ServiceApp.userPhone);
        try {
          dob = await dataSnapshot.get("Dob");
        } catch (e) {
          dob = "Not Available";
        }

        coverurl = await dataSnapshot.get("coverPhoto");
        profileurl = await dataSnapshot.get("profilePicture");
      });
    });
    print("Name: " + name);
    print("Email: " + email);
    print("Phone: " + phone);
    print("Dob: " + dob);
    print("Cover Photo: " + coverurl);
    print("Profile Pic: " + profileurl);
  }

  MyTrips obj = MyTrips();
  ImagePicker picker = ImagePicker();
  PickedFile imageCover;
  PickedFile imageProfile;
  List details = [
    'Phone Number',
    'Date of Birth',
    'Trips Completed',
    'Upcoming Trip'
  ];
  List customerDetails = [
    '8989898989',
    '26th April 2020',
    '50',
    'Delhi-Mumbai'
  ];
  List _intrests_categories = [
    'Adventure',
    'Art & Crafts',
    'Backpacking',
    'Beaches',
    'Maountains',
    'Historicla',
    'Natural Trails',
    'Romantic',
    'Biking',
    'Pub Crawling',
    'Shopping',
    'Culture',
    'Home Stay',
    'Trekking',
    'Waterfalls',
    'Diving',
    'Caving',
    'Offroading',
    'Events & Exhibitions',
    'Food',
    'Cities',
    'Heritage Walks',
    'Jungle safaris',
    'Cycle Tours',
    'Water Sports',
    'Winters Sports',
    'Pilgrimage',
    'Religious',
    'Meet ups',
    'Health & fitness',
    'Sustainable Liveing'
  ];
  List<double> fontSize = [20.0, 20.0, 40.0, 20.0];

  //rating
  double getRatting;
  getRating(rating) {
    setState(() {
      getRatting = rating;
    });
  }

  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;

//=========choice chips==========

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
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
            title: Center(child: Text('Travler Profile')),
            elevation: 0,
            backgroundColor: Color(0xff232931),
            brightness: Brightness.dark,
            textTheme: TextTheme(
              title: TextStyle(
                color: AppColor.c4,
                fontSize: 20,
              ),
            ),
          ),
          drawer: Drawerr(),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff393e46), Color(0xff4ecca3)])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height / 10 * 3,
                            width: MediaQuery.of(context).size.width / 10 * 11,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColor.c2, width: 2.0),
                              color: Color(0xFFEEEEEE),
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(coverurl),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.aspectRatio *
                                    360,
                                left: 4),
                            child: Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                //border: Border.all(),
                              ),
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(profileurl)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.aspectRatio *
                                    130,
                                left: MediaQuery.of(context).size.aspectRatio *
                                    300),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.aspectRatio *
                                    570,
                                left: 5),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        color: AppColor.c4,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 10.0),
              //   child: Column(
              //     children: [

              //          Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Container(

              //                 padding: EdgeInsets.all(10),

              //                 child: Stack(
              //                   children: [
              //                     //=======================================================
              //                       Center(
              //                       child: Container(
              //                         height: size,
              //                         width: size,

              //                         child: Stack(
              //                           children: [

              //                             ShaderMask(shaderCallback: (rect){

              //                                   return SweepGradient(
              //                                       startAngle: 0.0,
              //                                       endAngle: TWO_PI,
              //                                       // with the help of Stop we can limit the color of sweepgradient
              //                                       stops: [0.2,0.2],
              //                                       // name & email = 10%[0.1,0.1] ,
              //                                       // about trip = 10%[0.1,0.1]
              //                                       // travel intrest = 10%[0.1,0.1]
              //                                       //image upload = = 10%[0.1,0.1]
              //                                       // about him = 10%[0.1,0.1]
              //                                       // document upload 1 = 10%[0.1,0.1]
              //                                       // document upload 1 = 10%[0.1,0.1]

              //                                       center: Alignment.center,
              //                                       colors: [Colors.amber,Colors.grey.withAlpha(55)]
              //                                       ).createShader(rect);
              //                                   },
              //                                   child: Container(
              //                                     height: size,
              //                                     width: size,
              //                                     decoration: BoxDecoration(
              //                                       shape: BoxShape.circle,
              //                                       color: Colors.white,
              //                                     ),
              //                                   ),
              //                               ),

              //                             Center(
              //                               child: Container(
              //                                 height: size-10,
              //                                 width: size-10,
              //                                 decoration: BoxDecoration(
              //                                   color: Colors.white,
              //                                   border:
              //                                   Border.all(color: AppColor.c2, width: 2.0),
              //                                   shape: BoxShape.circle,

              //                                 ),
              //                                 child:  CircleAvatar(

              //                                   backgroundImage: image == null
              //                                       ? NetworkImage(
              //                                           'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
              //                                       : image,
              //                                 ),
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                         ),
              //                       ),
              //                     //=======================================================
              //                     //Container(
              //                     //   width: 100,
              //                     //   height: 100,
              //                     //   decoration: BoxDecoration(
              //                     //       shape: BoxShape.circle,
              //                     //       border:
              //                     //           Border.all(color: AppColor.c2, width: 2.0)),
              //                     //   child: CircleAvatar(
              //                     //     backgroundImage: image == null
              //                     //         ? NetworkImage(
              //                     //             'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
              //                     //         : image,
              //                     //   ),
              //                     // ),
              //                     Positioned(
              //                       bottom: 10,
              //                       right: 20,
              //                       child: InkWell(
              //                         onTap: () {
              //                           showModalBottomSheet(
              //                               backgroundColor: AppColor.c2,
              //                               context: context,
              //                               builder: ((builder) =>
              //                                   bottomSheet()));
              //                         },
              //                         child: Icon(Icons.camera_alt,
              //                             size: 20, color: Colors.grey),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),

              //       SizedBox(
              //         height: 8.0,
              //       ),
              //       Text(
              //         name1(),
              //         style: TextStyle(
              //             color: AppColor.c4,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 21),
              //       ),
              //       SizedBox(
              //         height: 8.0,
              //       ),
              //       Text(
              //         email1(),
              //         style: TextStyle(
              //             color: Colors.white54,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18),
              //       ),
              //       SizedBox(
              //         height: 10.0,
              //       ),
              //       MaterialButton(
              //         onPressed: () {
              //           Navigator.pushNamed(context, EditProfile.id);
              //         },
              //         elevation: 5.0,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30)),
              //         color: AppColor.c2,
              //         child: Text(
              //           'Edit Profile',
              //           style: TextStyle(
              //             color: AppColor.c4,
              //             fontWeight: FontWeight.bold,
              //             //fontSize: 18),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Container(
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    color: AppColor.c2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () {},
                    //   child: Card(
                    //     elevation: 5,
                    //     color: AppColor.c2,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 16.0,
                    //         vertical: 10.0,
                    //       ),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           IconButton(
                    //             onPressed: () {},
                    //             icon: Icon(
                    //               Icons.mail,
                    //               size: 40.0,
                    //               color: AppColor.c3,
                    //             ),
                    //           ),
                    //           SizedBox(width: 24.0),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               SingleChildScrollView(
                    //                 scrollDirection: Axis.horizontal,
                    //                 child: Row(
                    //                   children: [
                    //                     Text(
                    //                       "Email",
                    //                       style: TextStyle(
                    //                           fontSize: 18.0,
                    //                           color: Colors.grey),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               SizedBox(height: 4.0),
                    //               Text(
                    //                 email,
                    //                 style: TextStyle(
                    //                     fontSize: 15.0, color: AppColor.c4),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        color: AppColor.c2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 21.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 24.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  RatingBar.builder(
                                   ignoreGestures: true,
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: AppColor.c3,
                                    ),
                                    onRatingUpdate: (rating) {
                                      getRating(rating);
                                      //print(rating);
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 20),
                                    child: Text(
                                      getRatting.toString() == 'null'
                                          ? '3.0'
                                          : getRatting.toString(),
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        color: AppColor.c2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 21.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 40.0,
                                  color: AppColor.c3,
                                ),
                              ),
                              SizedBox(width: 24.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "DOB",
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    dob,
                                    style: TextStyle(
                                        fontSize: 18.0, color: AppColor.c4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Card(
                    //     elevation: 5,
                    //     color: AppColor.c2,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 16.0,
                    //         vertical: 21.0,
                    //       ),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           IconButton(
                    //             onPressed: () {},
                    //             icon: Icon(
                    //               Icons.phone,
                    //               size: 40.0,
                    //               color: AppColor.c3,
                    //             ),
                    //           ),
                    //           SizedBox(width: 24.0),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               Row(
                    //                 children: [
                    //                   Text(
                    //                     "Phone Number",
                    //                     style: TextStyle(
                    //                         fontSize: 18.0, color: Colors.grey),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 4.0),
                    //               Text(
                    //                 phone,
                    //                 style: TextStyle(
                    //                     fontSize: 18.0, color: AppColor.c4),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        color: AppColor.c2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 21.0,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                      "Traveling Intrests",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(
                                    //     Icons.check,
                                    //     size: 40.0,
                                    //     color: AppColor.c3,
                                    //   ),
                                    // ),
                                    SizedBox(width: 24.0),
                                    ServiceApp.selectedChoicesTravler.isNotEmpty
                                        ? SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Wrap(
                                                    spacing: 6.0,
                                                    runSpacing: 6.0,
                                                    children: List.generate(
                                                        ServiceApp
                                                            .selectedChoicesTravler
                                                            .length,
                                                        (int index) {
                                                      return InputChip(
                                                        label: Text(
                                                          ServiceApp
                                                                  .selectedChoicesTravler[
                                                              index],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        selected: true,
                                                        selectedColor:
                                                            AppColor.c3,
                                                      );
                                                    })),

                                                // Text(
                                                //   "Traveling Intrests",
                                                //   style: TextStyle(
                                                //       fontSize: 18.0, color: Colors.grey),
                                                // ),
                                                // SizedBox(height: 4.0),
                                                // Text(
                                                //   trips(),
                                                //   style: TextStyle(
                                                //       fontSize: 18.0, color: AppColor.c4),
                                                // ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "No Travel Intreset Yet ",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        color: AppColor.c2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 21.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.check,
                                  size: 40.0,
                                  color: AppColor.c3,
                                ),
                              ),
                              SizedBox(width: 24.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "Total Trips",
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    trips(),
                                    style: TextStyle(
                                        fontSize: 18.0, color: AppColor.c4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //              Container(
              //                margin: EdgeInsets.only(top: 300),
              //                decoration: BoxDecoration(
              //                    borderRadius: BorderRadius.only(
              //                  topLeft: Radius.circular(20),
              //                  topRight: Radius.circular(20),
              //                )),
              //                child: Padding(
              //                  padding: EdgeInsets.all(16),
              //                  child: GridView.builder(
              //                    itemCount: 4,
              //                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                      crossAxisCount: 2,
              //                    ),
              //                    itemBuilder: (context, index) => Container(
              //                      decoration: BoxDecoration(
              //                        gradient: LinearGradient(
              //                            colors: [Color(0xff393e46), Color(0xff4ecca3)]),
              //                        color: AppColor.c3,
              //                        borderRadius: BorderRadius.circular(20),
              //                      ),
              //                      margin: EdgeInsets.all(4),
              //                      child: Column(
              //                        mainAxisAlignment: MainAxisAlignment.start,
              //                        children: [
              //                          Text(
              //                            details[index],
              //                            style: TextStyle(
              //                                fontSize: 16,
              //                                color: AppColor.c2,
              //                                fontWeight: FontWeight.bold),
              //                          ),
              //                          SizedBox(
              //                            height: 40,
              //                          ),
              //                          Padding(
              //                            padding: const EdgeInsets.only(left: 8.0),
              //                            child: Container(
              //                              child: Text(
              //                                customerDetails[index],
              //                                style: TextStyle(
              //                                    fontSize: fontSize[index],
              //                                    fontWeight: FontWeight.bold,
              //                                    color: AppColor.c4),
              //                              ),
              //                            ),
              //                          )
              //                        ],
              //                      ),
              //                    ),
              //                  ),
              //                ),
              //              ),
            ],
          ),
        ),
      ),
    );
  }
}
// =============choice chips
// Widget buildChip(String label,){
// return Padding(
//   padding: const EdgeInsets.all(4.0),
//   child: ChoiceChip(
//     labelPadding: EdgeInsets.all(5.0),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(2),

//       ),

//       label: Text(
//           label,
//           style: TextStyle( color: AppColor.c4),
//         ),
//       elevation: 2.0,
//       shadowColor: Colors.grey[60],
//       padding: EdgeInsets.all(8.0),
//       selected: true,
//   ),
// );

// }

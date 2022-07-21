import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/MyTrips.dart';
import 'package:trivy/UpdateDocuments.dart';
import 'package:trivy/api/firebase_api.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/editIntrest.dart';
//import 'package:trivy/screens/Dashboard.dart';
//import 'package:trivy/admin.dart';
import 'package:trivy/trivyTech.dart';

import 'ZoomDrawer.dart';
import 'edit.dart';

final _earnerFireStore =
    firestore.FirebaseFirestore.instance.collection("Earner");

final _sharerFireStore =
    firestore.FirebaseFirestore.instance.collection("Sharer");

class Profile extends StatefulWidget {
  Profile({this.name, this.email, this.dob, this.phone, this.trips});
  final String name;
  final String email;
  final String dob;
  final String phone;
  final int trips;

  static const String id = 'Profile';
  @override
  _ProfileState createState() => _ProfileState();
}

int count = 0;
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
bool loading = false;
bool isLoggedIn = false;
String _email, _password;
bool _isSelected = false;
User user = _auth.currentUser;
bool isVerified;
String uid;
UploadTask task;
String _profileDown = '';
String _coverDown = '';
SharedPreferences sharedPreferences;

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    setState(() {
      isVerified = firebaseAuth.currentUser.emailVerified ? true : false;
    });
    getSelectedList();
    interest();
    allTrips();
    uid = FirebaseAuth.instance.currentUser.uid;
    super.initState();
    print(
        'Cover:' + ServiceApp.sharedPreferences.getString(ServiceApp.coverUrl));

    _profileDown =
        'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a';
    _coverDown =
        'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a';
  }

  interest() async {}
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

  DateTime date;
  DateTime intialDate = DateTime.now();
  var myFormat = DateFormat('d-MM-yyyy');
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: intialDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));

    setState(() {
      date = picked ?? date;

      ServiceApp.sharedPreferences
          .setString(ServiceApp.dob, myFormat.format(date));
    });
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
  String name1() {
    if (widget.name == null) {
      String nm =
          ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName) +
              " " +
              ServiceApp.sharedPreferences.getString(ServiceApp.userLastName);
      return nm;
    }
    return widget.name;
  }

  String trips() {
    return count.toString();
  }

  String recentTrip() {
    if (ServiceApp.sharedPreferences.getString(ServiceApp.from) == null) {
      return 'No-recent trip';
    }
    return ServiceApp.sharedPreferences.getString(ServiceApp.from) +
        "-" +
        ServiceApp.sharedPreferences.getString(ServiceApp.to);
  }

  String email1() {
    if (widget.email == null) {
      String nm = ServiceApp.sharedPreferences.getString(ServiceApp.userEmail);
      return nm;
    }
    return widget.email;
  }

  String dob1() {
    if (ServiceApp.sharedPreferences.getString(ServiceApp.dob) == null) {
      String nm = 'Set your DOB';
      return nm;
    }
    return ServiceApp.sharedPreferences.getString(ServiceApp.dob);
  }

  String phone1() {
    if (widget.phone == null) {
      String nm = ServiceApp.sharedPreferences.getString(ServiceApp.userPhone);
      return nm;
    }
    return widget.phone;
  }

  Widget bottomSheetCover() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Text(
              'Choose Cover Photo',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                    onPressed: () {
                      takePhotoCover(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Camera')),
                FlatButton.icon(
                    onPressed: () {
                      takePhotoCover(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text('Gallery')),
                FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        imageCover = null;
                      });
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                    label: Text('Remove'))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheetProfile() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Text(
              'Choose Profile Photo',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                    onPressed: () {
                      takePhotoProfile(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Camera')),
                FlatButton.icon(
                    onPressed: () {
                      takePhotoProfile(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text('Gallery')),
                FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        imageProfile = null;
                      });
                    },
                    icon: Icon(Icons.clear),
                    label: Text('Remove'))
              ],
            )
          ],
        ),
      ),
    );
  }

  getSelectedList() async {
    setState(() {
      firestore.FirebaseFirestore.instance
          .collection("users")
          .doc(ServiceApp.auth.currentUser.uid)
          .get()
          .then((dataSnapshot) async {
        try {
          ServiceApp.selectedChoices = await dataSnapshot.get("interests");
        } catch (e) {
          ServiceApp.selectedChoices = [];
          print(e);
        }
      });
    });
  }

  void takePhotoCover(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageCover = pickedFile;
    });
    if (imageCover == null) return;

    // final fileName = basename(image.path.split('/').last);
    final destination = uid + '/coverPhoto';
    print(destination);
    task = FirebaseApi.uploadFile(destination, File(imageCover.path));
    setState(() {});

    if (task == null) return;
    showLoadingIndicator(
        'Updating..', 'Please Wait...', context, buildUploadStatus(task));

    final snapshot = await task.whenComplete(() {});

    _coverDown = await snapshot.ref.getDownloadURL();
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.coverUrl, _coverDown);
    print('Download-Link(CoverPhoto): $_coverDown');
    updateCover();
  }

  void _updatePage() {
    setState(() {});
  }

  void takePhotoProfile(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageProfile = pickedFile;
    });
    if (imageProfile == null) return;

    // final fileName = basename(image.path.split('/').last);
    final destination = uid + '/profilePic';
    print(destination);
    task = FirebaseApi.uploadFile(destination, File(imageProfile.path));
    setState(() {});

    if (task == null) return;
    showLoadingIndicator(
        'Updating..', 'Please Wait...', context, buildUploadStatus(task));

    final snapshot = await task.whenComplete(() {});

    _profileDown = await snapshot.ref.getDownloadURL();
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userAvatarUrl, _profileDown);
    print('Download-Link(ProfilePhoto): $_profileDown');
    updateProfile();
  }

  Future updateProfile() async {
    await firestore.FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({
      "profilePicture": _profileDown,
    }, firestore.SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  Future updateCover() async {
    await firestore.FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({
      "coverPhoto": _coverDown,
    }, firestore.SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  void showLoadingIndicator(
      [String head, String text, BuildContext context, Widget widget]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87.withOpacity(0.8),
              content: LoadingIndicator(
                text: text,
                head: head,
                widget: widget,
              ),
            ));
      },
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            final snapshot1 = task.whenComplete(
                () => Navigator.popAndPushNamed(context, Profile.id));

            return Text(
              '$percentage %',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            );
          } else {
            return Text("Starting..");
          }
        },
      );

//=========choice chips==========

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
                  // floatingActionButton: FloatingActionButton(
                  //   backgroundColor: AppColor.c1,
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
                      color: AppColor.c1,
                    ),
                    leading: InkWell(
                      onTap: () => ZoomDrawer.of(context).toggle(),
                      child: Icon(Icons.menu),
                    ),
                    title: Center(child: Text('My Profile')),
                    // actions: <Widget>[
                    //   IconButton(
                    //     icon: Icon(Icons.settings),
                    //     onPressed: () {
                    //       Navigator.popAndPushNamed(context, Settings.id);
                    //     },
                    //   )
                    // ],
                    elevation: 0,
                    backgroundColor: AppColor.c6,
                    brightness: Brightness.light,
                    textTheme: TextTheme(
                      title: TextStyle(
                        color: AppColor.c2,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // drawer: Drawerr(),
                  body: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [AppColor.c1, AppColor.c6])),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SingleChildScrollView(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .aspectRatio *
                                            130,
                                        left: MediaQuery.of(context)
                                                .size
                                                .aspectRatio *
                                            300),
                                    child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: AppColor.c2,
                                            context: context,
                                            builder: ((builder) =>
                                                bottomSheetCover()));
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                      ),
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context)
                                                .size
                                                .aspectRatio *
                                            220),
                                    child: Container(
                                      child: Text(
                                        'Add Cover Photo',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                Colors.black.withOpacity(0.9),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              490,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              155),
                                      //alignment: Alignment(-0.5, 1.8),
                                      child: InkWell(
                                        onTap: () {
                                          print("Profile");
                                          showModalBottomSheet(
                                              backgroundColor: AppColor.c2,
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheetProfile()));
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                      )),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: AppColor.c2,
                                          context: context,
                                          builder: ((builder) =>
                                              bottomSheetCover()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10 *
                                              3,
                                      width: MediaQuery.of(context).size.width /
                                          10 *
                                          11,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.c1, width: 0.0),
                                        color: Color(0xFFEEEEEE),
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: imageCover == null
                                              ? NetworkImage(
                                                  ServiceApp.sharedPreferences
                                                      .getString(
                                                          ServiceApp.coverUrl),
                                                )
                                              : FileImage(
                                                  File(imageCover.path)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .aspectRatio *
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
                                      child: InkWell(
                                        onTap: () {
                                          print("Profile");
                                          showModalBottomSheet(
                                              backgroundColor: AppColor.c2,
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheetProfile()));
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: imageProfile == null
                                              ? NetworkImage(ServiceApp
                                                  .sharedPreferences
                                                  .getString(
                                                      ServiceApp.userAvatarUrl))
                                              : FileImage(
                                                  File(imageProfile.path)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    name1(),
                                    style: TextStyle(
                                        color: AppColor.c2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  isVerified
                                      ? Icon(
                                          Icons.verified_user_rounded,
                                          color: Colors.blue,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          isVerified
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Not Verified Mail!",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellowAccent),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await user.sendEmailVerification();
                                        Fluttertoast.showToast(
                                          msg: "Check Your Mail box",
                                          fontSize: 17,
                                          backgroundColor: AppColor.c1,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Click here to Verify",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    )
                                  ],
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
                        margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                            color: AppColor.c6,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print("Edit Profile");
                                Navigator.pushNamed(context, EditProfile.id);
                              },
                              child: Container(
                                  margin: EdgeInsets.all(15),
                                  // padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: AppColor.c6,
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: AppColor.c2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // ),
                                  )),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 5,
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.mail,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: AppColor.c2,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            email1(),
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: AppColor.c4),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, UpdateDocs.id);
                              },
                              child: Card(
                                elevation: 5,
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.document_scanner_outlined,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Text(
                                        "Uploaded Documents",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          // color: AppColor.c4
                                        ),
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
                            //           SizedBox(width: 24.0),
                            //           Column(
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: <Widget>[
                            //               Row(
                            //                 children: [
                            //                   Text(
                            //                     "Rating",
                            //                     style: TextStyle(
                            //                         fontSize: 18.0,
                            //                         color: Colors.grey),
                            //                   ),
                            //                 ],
                            //               ),
                            //               SizedBox(height: 4.0),
                            //               RatingBar.builder(
                            //                 initialRating: 3,
                            //                 minRating: 1,
                            //                 direction: Axis.horizontal,
                            //                 allowHalfRating: true,
                            //                 itemCount: 5,
                            //                 itemPadding:
                            //                     EdgeInsets.symmetric(horizontal: 4.0),
                            //                 itemBuilder: (context, _) => Icon(
                            //                   Icons.star,
                            //                   color: AppColor.c3,
                            //                 ),
                            //                 onRatingUpdate: (rating) {
                            //                   getRating(rating);
                            //                   //print(rating);
                            //                 },
                            //               ),
                            //             ],
                            //           ),
                            //           Column(
                            //             children: [
                            //               Padding(
                            //                 padding: const EdgeInsets.only(
                            //                     left: 10.0, top: 20),
                            //                 child: Text(
                            //                   getRatting.toString() == 'null'
                            //                       ? '3.0'
                            //                       : getRatting.toString(),
                            //                   style: TextStyle(
                            //                       fontSize: 18.0, color: Colors.grey),
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 5,
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 21.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.calendar_today,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "DOB",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: AppColor.c2),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  _selectDate(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            dob1(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: AppColor.c4),
                                          ),
                                        ],
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
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 21.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.phone,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Phone Number",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: AppColor.c2),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            phone1() == null
                                                ? 'No Number Added'
                                                : phone1(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: AppColor.c4),
                                          ),
                                        ],
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
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 21.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
                                            child: Text(
                                              "Traveling Intrests",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: AppColor.c2),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditIntreste()),
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // IconButton(
                                            //   onPressed: () {},
                                            //   icon: Icon(
                                            //     Icons.check,
                                            //     size: 40.0,
                                            //     color: AppColor.c6,
                                            //   ),
                                            // ),
                                            SizedBox(width: 24.0),
                                            ServiceApp
                                                    .selectedChoices.isNotEmpty
                                                ? SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        Wrap(
                                                            spacing: 6.0,
                                                            runSpacing: 6.0,
                                                            children: List.generate(
                                                                ServiceApp
                                                                    .selectedChoices
                                                                    .length,
                                                                (int index) {
                                                              return InputChip(
                                                                label: Text(
                                                                  ServiceApp
                                                                          .selectedChoices[
                                                                      index],
                                                                  style: TextStyle(
                                                                      // color:
                                                                      //     AppColor
                                                                      //         .c1,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                                selected: true,
                                                                selectedColor:
                                                                    AppColor.c4,
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
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      "No Travel Intreset Yet Please Update",
                                                      style: TextStyle(
                                                          fontSize: 15),
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
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 21.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.check,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Total Trips",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: AppColor.c2),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            trips(),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: AppColor.c4,
                                            ),
                                          ),
                                        ],
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
                                color: AppColor.c6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 21.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.directions_walk,
                                          size: 40.0,
                                          color: AppColor.c2,
                                        ),
                                      ),
                                      SizedBox(width: 24.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Upcoming Trip",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: AppColor.c2),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            recentTrip(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: AppColor.c4),
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
            ),
          ),
        ));
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

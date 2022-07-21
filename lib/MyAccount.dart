import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:marquee/marquee.dart';
import 'package:trivy/Earn.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/Share.dart';
import 'package:trivy/UpdateDocuments.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';
//import 'trivyTechmarquee/marquee.dart';

class MyAccount extends StatefulWidget {
  static const String id = 'MyAccount';
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool checkdocs = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    setState(() {
      checkDocs();
    });
    super.initState();
    //  readData(FirebaseAuth.instance.currentUser);
  }

  String aadharr = 'Not Added';
  String dl = 'Not Added';
  String pan = 'Not Added';
  String pass = 'Not Added';
  // ignore: unused_element
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => exit(0),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _marquee() {
    // readData(FirebaseAuth.instance.currentUser) ;

    checkdocs = checkDocs();

    if (checkdocs) {
      print("Sahi Hai");

      return Container(
        color: AppColor.c3,
        height: MediaQuery.of(context).size.height / 10 * .3,
        child: Marquee(
          text: 'Please Upload Your Documents',
          style: TextStyle(fontWeight: FontWeight.bold),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 100.0,
          pauseAfterRound: Duration(seconds: 2),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      );
    } else {
      print("gadbad hai");
      setState(() {});
      return Container();
    }
  }

  final List imgList = [
    'images/Slider1-1.png',
    'images/Slider2-1.png',
    'images/Slider3-1.png',
  ];
  @override
  Widget build(BuildContext context) {
    // print(ServiceApp.sharedPreferences.getString(ServiceApp.userAvatarUrl));
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          child: Center(
            child: GestureDetector(
              child: GestureDetector(
                onPanStart: (var on) {
                  on != null ? ZoomDrawer.of(context).toggle() : null;
                },
                child: Scaffold(
                  extendBodyBehindAppBar: false,
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
                    iconTheme: IconThemeData(color: AppColor.c1),
                    centerTitle: true,
                    leading: InkWell(
                      onTap: () => ZoomDrawerrState().controller.toggle(),
                      child: Icon(Icons.menu),
                    ),
                    title: Center(
                        child: Text(
                      'Home',
                      style: TextStyle(color: AppColor.c1, letterSpacing: 2),
                    )),
                    elevation: 0.0,
                    bottomOpacity: 0.0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          Navigator.pushNamed(context, Profile.id);
                        },
                      )
                    ],
                    backgroundColor: AppColor.c6,
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
                  body: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: AppColor.c1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.c6,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(55),
                                    bottomRight: Radius.circular(55))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _marquee(),
                                checkDocs()
                                    ? Center(
                                        child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateDocs()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Click To Update Documents",
                                            style: TextStyle(
                                                color: AppColor.c1,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ))
                                    : Text(""),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 58),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                              color: Color(0xff232931),
                                              fontSize: 60.0,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 2),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText('TRIVY'),
                                            ],
                                            isRepeatingAnimation: true,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          'Seek Kar, Pick Kar, Earn kar!',
                                          style: TextStyle(
                                            color: Color(0xff232931),
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Container(
                                //   child: Swiper(
                                //     itemCount: 3,
                                //     autoplay: true,
                                //     layout: SwiperLayout.TINDER,
                                //     itemHeight:
                                //         MediaQuery.of(context).size.height / 10 * 3.5,
                                //     itemWidth: MediaQuery.of(context).size.width / 10 * 6,
                                //     itemBuilder: (BuildContext context, int index) {
                                //       return Image.asset(
                                //         imgList[index],
                                //         fit: BoxFit.fill,
                                //         repeat: ImageRepeat.repeat,
                                //         color: AppColor.c1,
                                //         colorBlendMode: BlendMode.colorDodge,
                                //       );
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 50.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: SizedBox(
                                  width: 175.0,
                                  height: 50.0,
                                  child: Hero(
                                    tag: 'share',
                                    child: RaisedButton.icon(
                                      color: AppColor.c6,
                                      elevation: 07.0,
                                      textColor: AppColor.c2,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(55.0))),
                                      icon: Icon(Icons.trending_up),
                                      label: Text(
                                        'Share',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, Share.id);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 18.0,
                                    bottom: 18.0,
                                    left: 65.0,
                                    right: 65.0),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      color: AppColor.c2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "OR",
                                      style: TextStyle(
                                        color: AppColor.c2,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColor.c2,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: SizedBox(
                                  height: 50.0,
                                  width: 175.0,
                                  child: Hero(
                                    tag: 'earn',
                                    child: RaisedButton.icon(
                                      color: AppColor.c3,
                                      elevation: 07.0,
                                      textColor: AppColor.c2,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(5.0),
                                              right: Radius.circular(5.0))),
                                      icon: Icon(Icons.transit_enterexit),
                                      label: Text(
                                        'Earn ',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, Earn.id);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // Future readData(User user) async {
  //   await firestore.FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user.uid)
  //       .get()
  //       .then((dataSnapshot) async {
  //     await ServiceApp.sharedPreferences.setString(
  //         ServiceApp.aadhaarUrl, dataSnapshot.get(ServiceApp.aadhaarUrl));
  //     await ServiceApp.sharedPreferences
  //         .setString(ServiceApp.dlUrl, dataSnapshot.get(ServiceApp.dlUrl));
  //     await ServiceApp.sharedPreferences.setString(
  //         ServiceApp.passportUrl, dataSnapshot.get(ServiceApp.passportUrl));
  //     await ServiceApp.sharedPreferences
  //         .setString(ServiceApp.panUrl, dataSnapshot.get(ServiceApp.panUrl));
  //
  //     //print(dataSnapshot.get('profilePicture').toString());
  //   });
  // }

  String addhar() {
    return ServiceApp.sharedPreferences.getString(ServiceApp.aadhaarUrl);
  }

  String pancard() {
    return ServiceApp.sharedPreferences.getString(ServiceApp.panUrl);
  }

  String dlcard() {
    return ServiceApp.sharedPreferences.getString(ServiceApp.dlUrl);
  }

  String passport() {
    return ServiceApp.sharedPreferences.getString(ServiceApp.passportUrl);
  }

  bool checkDocs() {
    aadharr = addhar();
    dl = dlcard();
    pan = pancard();
    pass = passport();

    if (aadharr == 'Not Added' &&
        dl == 'Not Added' &&
        pan == 'Not Added' &&
        pass == 'Not Added') {
      print(aadharr);
      print(dl);
      print(pan);
      print(pass);

      return true;
    } else {
      print(aadharr);
      print(dl);
      print(pan);
      print(pass);

      return false;
    }
  }
}

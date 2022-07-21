import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trivy/Match.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

import 'ZoomDrawer.dart';

enum UserType {
  Sharer,
  Earner,
  NoType,
}

var typeOfUser = UserType.NoType;
int count = 0;

//
class Share extends StatefulWidget {
  static const String id = 'share';
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  dynamic sliderValue = 1;
  DateTime _dateTime;
  dynamic amountQ;

  // UserType typeOfUser = UserType.Sharer;
  // final typeOfUserjjjj = UserType.Earner;

  final fromEditingController = TextEditingController();
  final toEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final flightEditingController = TextEditingController();
  final amountEditingController = TextEditingController();
  final nameEditingController = TextEditingController();

  @override
  void initState() {
    typeOfUser = UserType.Earner;
    super.initState();
  }

  @override
  void dispose() {
    fromEditingController.dispose();
    toEditingController.dispose();
    dateEditingController.dispose();
    flightEditingController.dispose();
    amountEditingController.dispose();
    nameEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('UPDATE!'),
            content: new Text('Go to MyTrips and Click on Find a Match'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, ZoomDrawerr.id),
                child: Text("OK!"),
              ),
            ],
          ),
        ) ??
        false;
  }

  final _formKey = GlobalKey<FormState>();
  final sharerImages = [
    Image.asset('images/S1.jpg' ?? "") ?? null,
    Image.asset('images/S2.jpg' ?? "") ?? null,
    Image.asset('images/S3 (1).jpg' ?? "") ?? null,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.c1,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColor.c1,
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: ZoomDrawer.of(context).toggle(),
          // ),
          title: Center(child: Text('Share')),
          elevation: 0,
          backgroundColor: AppColor.c6,
          brightness: Brightness.light,
          leading: InkWell(
            onTap: () => ZoomDrawer.of(context).toggle(),
            child: Icon(Icons.menu),
          ),
          textTheme: TextTheme(
              // ignore: deprecated_member_use
              title: TextStyle(
            color: AppColor.c2,
            fontSize: 20,
          )),
        ),
        // drawer: Drawerr(),
        body: SafeArea(
          child: Container(
            color: AppColor.c1,
            child: Form(
              key: _formKey,
              // initialValue: {
              //   'date': DateTime.now(),
              //   'accept_terms': false,
              // },
              // autovalidate: true,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: CarouselSlider(
                      items: sharerImages,
                      //height: 400,
                      aspectRatio: 16 / 11,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 1800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      // onPageChanged: (index) {},
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Flight Details',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColor.c2,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      controller: fromEditingController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.flight_takeoff, color: AppColor.c2),
                        labelText: "From",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: TextFormField(
                      controller: toEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.flight_land, color: AppColor.c2),
                        labelText: "To",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: TextFormField(
                      controller: flightEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },

                      //attribute: "Flight Number",
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.flight,
                          color: AppColor.c2,
                        ),
                        labelText: "Flight Number",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: FormBuilderDateTimePicker(
                      controller: dateEditingController,
                      attribute: "date",
                      inputType: InputType.both,
                      onChanged: (DateTime value) {
                        _dateTime = value;
                      },
                      //validators: [
                      // FormBuilderValidators.date(),
                      //],
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: AppColor.c2,
                        ),
                        labelText: "Travel Details",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: FormBuilderSlider(
                      onChanged: (value) {
                        sliderValue = value;
                        setState(() {
                          amountEditingController.value = TextEditingValue(
                              text: value <= 5 ? '500' : '1500');
                        });
                      },
                      attribute: "slider",
                      validators: [FormBuilderValidators.min(1)],
                      min: 1.0,
                      max: 15.0,
                      initialValue: 1.0,
                      divisions: 28,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.card_travel,
                          color: AppColor.c2,
                        ),
                        labelText: "Extra Luggage you have(in Kgs)",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amountEditingController,
                      enabled: false,
                      decoration: InputDecoration(
                        icon: FaIcon(
                          FontAwesomeIcons.rupeeSign,
                          color: AppColor.c2,
                        ),
                        labelText: "You have to pay",
                      ),
                      // validators: [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 100.0),
                    child: SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: Hero(
                        tag: 'share',
                        child: RaisedButton.icon(
                          color: AppColor.c3,
                          elevation: 10.0,
                          textColor: AppColor.c2,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(50.0),
                                  right: Radius.circular(50.0))),
                          icon: Icon(FontAwesomeIcons.calendarCheck),
                          label: Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              onSaved();
                              //_onBackPressed();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSaved() async {
    final sharerRef = firestore.FirebaseFirestore.instance.collection("Sharer");
    bool isValid = false;
    if (_formKey.currentState != null) {
      isValid = _formKey.currentState.validate();
      _formKey.currentState.save();
    }
    if (!isValid) {
      return;
    } else {
      await sharerRef.add({
        "name":
            ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName) +
                " " +
                ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
        "from": fromEditingController.text,
        "to": toEditingController.text,
        "flightnumber": flightEditingController.text,
        "date": _dateTime,
        "weight": sliderValue,
        "price": double.parse(amountEditingController.text),
        "uid": ServiceApp.auth.currentUser.uid,
        "availability": 0,
      });
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.from, fromEditingController.text);
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.to, toEditingController.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Match(
                    usertype: 'sharer',
                    weight: sliderValue,
                    date: _dateTime,
                    flightNo: flightEditingController.text,
                    name: ServiceApp.sharedPreferences
                            .getString(ServiceApp.userFirstName) +
                        " " +
                        ServiceApp.sharedPreferences
                            .getString(ServiceApp.userLastName),
                  )));
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:trivy/TC.dart';
// import 'package:trivy/loginpage.dart';
// import 'package:trivy/Earn.dart';
// import 'package:trivy/Share.dart';
// import 'package:trivy/MyAccount.dart';
// import 'package:trivy/Wallet.dart';
// import 'package:trivy/Contact.dart';
// import 'package:trivy/About.dart';
// import 'package:trivy/MyTrips.dart';
// import 'package:trivy/Help&Support.dart';
// import 'package:trivy/How.dart';
// import 'package:trivy/Profile.dart';
// import 'package:trivy/Settings.dart';
// import 'package:place_picker/place_picker.dart';
// import 'package:trivy/Match.dart';
//
// class Share extends StatefulWidget {
//   static const String id = 'share';
//   @override
//   _ShareState createState() => _ShareState();
// }
//
// class _ShareState extends State<Share> {
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
//             color: Color(0xffeeeeee),
//           ),
//           title: Center(child: Text('Share')),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 Navigator.pushNamed(context, Settings.id);
//               },
//             )
//           ],
//           elevation: 0,
//           backgroundColor: Color(0xff232931),
//           brightness: Brightness.dark,
//           textTheme: TextTheme(
//               title: TextStyle(
//             color: AppColor.c4,
//             fontSize: 20,
//           )),
//         ),
//         drawer: Drawer(
//           child: Container(
//             color: AppColor.c1,
//             child: ListView(
//               children: <Widget>[
//                 UserAccountsDrawerHeader(
//                   decoration: BoxDecoration(
//                     color: AppColor.c3,
//                   ),
//                   accountName: Text(
//                     'Pulkit Agarwal',
//                     style: TextStyle(
//                       color: AppColor.c2,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   accountEmail: Text(
//                     'pulkitagarwal2899@gmail.com',
//                     style: TextStyle(
//                       color: AppColor.c2,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   currentAccountPicture: CircleAvatar(
//                     backgroundColor: AppColor.c4,
//                     child: Text('P'),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text('Home'),
//                   leading: Icon(Icons.home),
//                   onTap: () {
//                     Navigator.pushNamed(context, MyAccount.id);
//                   },
//                 ),
//                 Divider(
//                   color: AppColor.c4,
//                 ),
//                 ListTile(
//                   title: Text('My Profile'),
//                   leading: Icon(Icons.account_circle),
//                   onTap: () {
//                     Navigator.pushNamed(context, Profile.id);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('My Trips'),
//                   leading: Icon(Icons.flight),
//                   onTap: () {
//                     Navigator.pushNamed(context, MyTrips.id);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('My Wallet'),
//                   leading: Icon(Icons.account_balance_wallet),
//                   onTap: () {
//                     Navigator.pushNamed(context, Wallet.id);
//                   },
//                 ),
//                 Divider(
//                   color: AppColor.c4,
//                 ),
//                 ListTile(
//                   title: Text('How We Work'),
//                   leading: Icon(Icons.info),
//                   onTap: () {
//                     Navigator.pushNamed(context, How.id);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Help & Support'),
//                   leading: Icon(Icons.help),
//                   onTap: () {
//                     Navigator.pushNamed(context, Help.id);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('About Us'),
//                   leading: Icon(Icons.info),
//                   onTap: () {
//                     Navigator.pushNamed(context, About.id);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Contact Us'),
//                   leading: Icon(Icons.question_answer),
//                   onTap: () {
//                     Navigator.pushNamed(context, Contact.id);
//                   },
//                 ),
//                 Divider(
//                   color: AppColor.c4,
//                 ),
//                 ListTile(
//                   title: Text('Terms & Conditions'),
//                   leading: Icon(Icons.content_paste),
//                   onTap: () {
//                     Navigator.pushNamed(context, Terms.id);
//                   },
//                 ),
//                 Divider(
//                   color: AppColor.c4,
//                 ),
//                 ListTile(
//                   title: Text('Log Out'),
//                   leading: Icon(Icons.exit_to_app),
//                   onTap: () {
//                     Navigator.pushNamed(context, LoginPage.id);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Container(
//             color: AppColor.c1,
//             child: FormBuilder(
//               initialValue: {
//                 'date': DateTime.now(),
//                 'accept_terms': false,
//               },
//               autovalidate: true,
//               child: ListView(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.all(10.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(50.0),
//                       child: Column(
//                         children: <Widget>[
//                           Center(
//                             child: Text(
//                               'SHARER:',
//                               style: TextStyle(
//                                 fontSize: 24.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColor.c4,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30.0,
//                           ),
//                           Center(
//                             child: Text(
//                               '''
// The one with Extra luggage willing to share their luggage.
//
// Enter your trip and luggage details
//
// Select an Earner to share luggage with.
//
// Confirm, Pay ,Exchange, Travel
//
// Repeat.''',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15.0,
//                                 wordSpacing: 2.0,
//                                 color: AppColor.c4,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(
//                             colors: [Color(0xff232931), Color(0xff4ecca3)])),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'Flight Details',
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: AppColor.c4,
//                         ),
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 25.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.flight_takeoff, color: AppColor.c3),
//                         labelText: "From",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 25.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.flight_land, color: AppColor.c3),
//                         labelText: "To",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 25.0),
//                     child: FormBuilderTextField(
//                       attribute: "Flight Number",
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.flight,
//                           color: AppColor.c3,
//                         ),
//                         labelText: "Flight Number",
//                       ),
//                       validators: [],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 25.0),
//                     child: FormBuilderDateTimePicker(
//                       attribute: "date",
//                       inputType: InputType.both,
//                       //validators: [
//                       // FormBuilderValidators.date(),
//                       //],
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.calendar_today,
//                           color: AppColor.c3,
//                         ),
//                         labelText: "Travel Details",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 25.0),
//                     child: FormBuilderSlider(
//                       attribute: "slider",
//                       validators: [FormBuilderValidators.min(1)],
//                       min: 1.0,
//                       max: 15.0,
//                       initialValue: 1.0,
//                       divisions: 28,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.card_travel,
//                           color: AppColor.c3,
//                         ),
//                         labelText: "Extra Luggage you have(in Kgs)",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 30.0, horizontal: 100.0),
//                     child: SizedBox(
//                       width: 150.0,
//                       height: 50.0,
//                       child: RaisedButton.icon(
//                         color: AppColor.c3,
//                         elevation: 10.0,
//                         textColor: AppColor.c2,
//                         shape: ContinuousRectangleBorder(
//                             borderRadius: BorderRadius.horizontal(
//                                 left: Radius.circular(50.0),
//                                 right: Radius.circular(50.0))),
//                         icon: Icon(FontAwesomeIcons.calendarCheck),
//                         label: Text(
//                           'Share',
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.pushNamed(context, Match.id);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

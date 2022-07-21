import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/About.dart';
import 'package:trivy/Contact.dart';
import 'package:trivy/Dashboard.dart';
import 'package:trivy/Earn.dart';
import 'package:trivy/Help&Support.dart';
import 'package:trivy/How.dart';
import 'package:trivy/LoginPhone.dart';
import 'package:trivy/Match.dart';
import 'package:trivy/MyAccount.dart';
import 'package:trivy/MyTrips.dart';
import 'package:trivy/MyWallet.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/Settings.dart';
import 'package:trivy/Share.dart';
import 'package:trivy/SignUpNew.dart';
import 'package:trivy/TC.dart';
import 'package:trivy/Track.dart';
import 'package:trivy/UpdateDocuments.dart';
import 'package:trivy/Wallet.dart';
import 'package:trivy/Welcome/welcome_screen.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/edit.dart';
import 'package:trivy/loginpage.dart';
import 'package:trivy/my_matches.dart';
import 'package:trivy/reset.dart';
import 'package:trivy/signup.dart';
import 'package:trivy/trivyTech.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceApp.auth = FirebaseAuth.instance;
  ServiceApp.sharedPreferences = await SharedPreferences.getInstance();
  ServiceApp.firestore = firestore.FirebaseFirestore.instance;
  // checkLocation();
  // ignore: unused_local_variable
  bool isLoading = true;
  runApp(MaterialApp(
    theme: ThemeData.light(),

    initialRoute: Page1.id,
    routes: {
      EditProfile.id: (context) => EditProfile(),
      LoginPage.id: (context) => LoginPage(),
      LoginPagePhone.id: (context) => LoginPagePhone(),
      SignUpPage.id: (context) => SignUpPage(),
      SignUp.id: (context) => SignUp(),
      MyAccount.id: (context) => MyAccount(),
      Terms.id: (context) => Terms(),
      Share.id: (context) => Share(),
      Wallet.id: (context) => Wallet(),
      Earn.id: (context) => Earn(),
      Contact.id: (context) => Contact(),
      About.id: (context) => About(),
      MyTrips.id: (context) => MyTrips(),
      Help.id: (context) => Help(),
      How.id: (context) => How(),
      Profile.id: (context) => Profile(),
      Settings.id: (context) => Settings(),
      Match.id: (context) => Match(),
      Track.id: (context) => Track(),
      MyWallet.id: (context) => MyWallet(),
      ResetScreen.id: (context) => ResetScreen(),
      Dashboard.id: (context) => Dashboard(),
      UpdateDocs.id: (context) => UpdateDocs(),
      MyMatch.id: (context) => MyMatch(),
    },
    // home:Dashboard(),
    home: SplashScrn(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScrn extends StatefulWidget {
  @override
  _SplashScrnState createState() => _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  Future readData(User user) async {
    firestore.FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((dataSnapshot) async {
      try {
        await ServiceApp.sharedPreferences
            .setString("uid", dataSnapshot.get(ServiceApp.userUID));
        await ServiceApp.sharedPreferences.setString(
            ServiceApp.userEmail, dataSnapshot.get(ServiceApp.userEmail));
        await ServiceApp.sharedPreferences.setString(ServiceApp.userFirstName,
            dataSnapshot.get(ServiceApp.userFirstName));
        await ServiceApp.sharedPreferences.setString(
            ServiceApp.userLastName, dataSnapshot.get(ServiceApp.userLastName));
        await ServiceApp.sharedPreferences.setString(ServiceApp.userPhone,
            dataSnapshot.get(ServiceApp.userPhone).toString());
        await ServiceApp.sharedPreferences.setString(ServiceApp.userAvatarUrl,
            dataSnapshot.get('profilePicture').toString());
        await ServiceApp.sharedPreferences.setString(
            ServiceApp.coverUrl, dataSnapshot.get('coverPhoto').toString());
        await ServiceApp.sharedPreferences.setString(ServiceApp.aadhaarUrl,
            dataSnapshot.get(ServiceApp.aadhaarUrl).toString());
        await ServiceApp.sharedPreferences.setString(
            ServiceApp.dlUrl, dataSnapshot.get(ServiceApp.dlUrl).toString());
        await ServiceApp.sharedPreferences.setString(ServiceApp.passportUrl,
            dataSnapshot.get(ServiceApp.passportUrl).toString());
        await ServiceApp.sharedPreferences.setString(
            ServiceApp.panUrl, dataSnapshot.get(ServiceApp.panUrl).toString());
      } catch (e) {
        print("Caught Exception");
        ServiceApp.auth.currentUser.delete();
        await ServiceApp.sharedPreferences.clear();
      }
      //print(dataSnapshot.get('profilePicture').toString());
    });
  }

  @override
  void initState() {
    super.initState();
    if (ServiceApp.auth.currentUser != null)
      readData(ServiceApp.auth.currentUser);
    Timer(Duration(seconds: 5), () async {
      if (await ServiceApp.auth.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MyAccount();
        }));
      } else {
        ServiceApp.sharedPreferences.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Page1();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: AppColor.c5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/Logo.png'),
              SizedBox(
                height: 5,
              ),
              Text(
                'Trivy Technologies Pvt. Ltd.',
                style: TextStyle(
                  color: AppColor.c4,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Seek Kar, Pick Kar, Earn Kar!',
                style: TextStyle(
                  color: AppColor.c4,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SpinKitFadingCube(
                duration: const Duration(milliseconds: 500),
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? AppColor.c6 : AppColor.c4,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  static const String id = 'page1';
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}

// void checkLocation() async {
//   Location location = new Location();
//
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.DENIED) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.GRANTED) {
//       return;
//     }
//   }
//
//   _locationData = await location.getLocation();
// }

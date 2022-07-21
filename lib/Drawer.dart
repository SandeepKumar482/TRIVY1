import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivy/Welcome/welcome_screen.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/my_matches.dart';
import 'package:trivy/trivyTech.dart';

import 'About.dart';
import 'Contact.dart';
import 'Help&Support.dart';
import 'How.dart';
import 'MyAccount.dart';
import 'MyTrips.dart';
import 'Profile.dart';
import 'TC.dart';
import 'loginpage.dart';

class Drawerr extends StatefulWidget {
  final PickedFile img;

  //final FirebaseUser user;
  const Drawerr({this.img});
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> logout() async {
    try {
      if (ServiceApp.sharedPreferences.getString(ServiceApp.typeLogin) ==
          "google") {
        print("GoogleSignIn");

        await googleSignIn.disconnect();
      }

      firebaseAuth.signOut();
    } catch (e, st) {
      FlutterError.reportError(FlutterErrorDetails(exception: e, stack: st));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColor.c1,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.c3,
              ),
              accountName: Text(
                ServiceApp.sharedPreferences
                        .getString(ServiceApp.userFirstName) +
                    " " +
                    ServiceApp.sharedPreferences
                        .getString(ServiceApp.userLastName),
                style: TextStyle(
                  color: AppColor.c2,
                  fontSize: 16.0,
                ),
              ),
              accountEmail: Text(
                ServiceApp.sharedPreferences.getString(ServiceApp.userEmail),
                style: TextStyle(
                  color: AppColor.c2,
                  fontSize: 16.0,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColor.c4,
                backgroundImage: NetworkImage(ServiceApp.sharedPreferences
                    .getString(ServiceApp.userAvatarUrl)),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyAccount.id);
              },
            ),
            Divider(
              color: AppColor.c4,
            ),
            ListTile(
              title: Text('My Profile'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.pushReplacementNamed(context, Profile.id);
              },
            ),
            ListTile(
              title: Text('My Trips'),
              leading: Icon(Icons.flight),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyTrips.id);
              },
            ),
            ListTile(
              title: Text('My Wallet'),
              leading: Icon(Icons.account_balance_wallet),
              onTap: () {
                Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
              },
            ),
            ListTile(
              title: Text('My Matches'),
              leading: Icon(Icons.airline_seat_recline_extra_sharp),
              onTap: () {
                Navigator.pushReplacementNamed(context, MyMatch.id);
              },
            ),
            Divider(
              color: AppColor.c4,
            ),
            ListTile(
              title: Text('How To Use'),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.pushReplacementNamed(context, How.id);
              },
            ),
            ListTile(
              title: Text('FAQs'),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.pushReplacementNamed(context, Help.id);
              },
            ),
            ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.pushReplacementNamed(context, About.id);
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              leading: Icon(Icons.question_answer),
              onTap: () {
                Navigator.pushReplacementNamed(context, Contact.id);
              },
            ),
            Divider(
              color: AppColor.c4,
            ),
            ListTile(
              title: Text('Terms & Conditions'),
              leading: Icon(Icons.content_paste),
              onTap: () {
                Navigator.pushReplacementNamed(context, Terms.id);
              },
            ),
            Divider(
              color: AppColor.c4,
            ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WelcomeScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trivy/MyAccount.dart';
import 'package:trivy/TC.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/loginpage.dart';

import 'package:trivy/Wallet.dart';
import 'package:trivy/About.dart';
import 'package:trivy/Contact.dart';
import 'package:trivy/MyTrips.dart';
import 'package:trivy/Help&Support.dart';
import 'package:trivy/How.dart';
import 'package:trivy/Profile.dart';
import 'trivyTech.dart';

class Settings extends StatefulWidget {
  static const String id = 'Settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Future<void> logout() async {
    try {
      if (ServiceApp.sharedPreferences.getString(ServiceApp.typeLogin) == "google") {
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
    return WillPopScope(
      onWillPop: (){
        Navigator.popAndPushNamed(context, MyAccount.id);
      },
      child: SafeArea(
        child: Center(
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
              title: Center(child: Text('Settings')),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, Settings.id);
                  },
                )
              ],
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
            drawer: Drawer(
              child: Container(
                color: AppColor.c1,
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColor.c3,
                      ),
                      accountName: Text(
                        ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName)+" "+ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
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
                        backgroundImage:  NetworkImage(ServiceApp.sharedPreferences.getString(ServiceApp.userAvatarUrl)),
                      ),
                    ),
                    ListTile(
                      title: Text('My Profile'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        Navigator.pushNamed(context, Profile.id);
                      },
                    ),
                    ListTile(
                      title: Text('My Trips'),
                      leading: Icon(Icons.flight),
                      onTap: () {
                        Navigator.pushNamed(context, MyTrips.id);
                      },
                    ),
                    ListTile(
                      title: Text('My Wallet'),
                      leading: Icon(Icons.account_balance_wallet),
                      onTap: () {
                        Navigator.pushNamed(context, Wallet.id);
                      },
                    ),
                    Divider(
                      color: AppColor.c4,
                    ),
                    ListTile(
                      title: Text('How We Work'),
                      leading: Icon(Icons.info),
                      onTap: () {
                        Navigator.pushNamed(context, How.id);
                      },
                    ),
                    ListTile(
                      title: Text('Help & Support'),
                      leading: Icon(Icons.help),
                      onTap: () {
                        Navigator.pushNamed(context, Help.id);
                      },
                    ),
                    ListTile(
                      title: Text('About Us'),
                      leading: Icon(Icons.info),
                      onTap: () {
                        Navigator.pushNamed(context, About.id);
                      },
                    ),
                    ListTile(
                      title: Text('Contact Us'),
                      leading: Icon(Icons.question_answer),
                      onTap: () {
                        Navigator.pushNamed(context, Contact.id);
                      },
                    ),
                    Divider(
                      color: AppColor.c4,
                    ),
                    ListTile(
                      title: Text('Terms & Conditions'),
                      leading: Icon(Icons.content_paste),
                      onTap: () {
                        Navigator.pushNamed(context, Terms.id);
                      },
                    ),
                    Divider(
                      color: AppColor.c4,
                    ),
                    ListTile(
                      title: Text('Log Out'),
                      leading: Icon(Icons.exit_to_app),
                      onTap: ()  {
                        logout();
                        Navigator.pushNamed(context, LoginPage.id);

                      },
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
}

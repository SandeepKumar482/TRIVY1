import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/Otp.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/loading_indicator.dart';
import 'package:trivy/loginpage.dart';
import 'package:trivy/trivyTech.dart';

class SignUp extends StatefulWidget {
  static const id = "SignUpNew";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
    }
    setState(() {
      loading = false;
    });
  }

  Future readData(User user) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((dataSnapshot) async {
      await ServiceApp.sharedPreferences
          .setString("uid", dataSnapshot.get(ServiceApp.userUID));
      await ServiceApp.sharedPreferences.setString(
          ServiceApp.userEmail, dataSnapshot.get(ServiceApp.userEmail));
      await ServiceApp.sharedPreferences.setString(
          ServiceApp.userFirstName, dataSnapshot.get(ServiceApp.userFirstName));
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
      //print(dataSnapshot.get('profilePicture').toString());
    });
  }

  void showLoadingIndicator([String text]) {
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
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }

  Future handleSignIn() async {
    final coverphoto =
        'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=cf30e3cc-8f53-43e9-8fb6-687a41f66de1';
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    showLoadingIndicator('Loading..');
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    Navigator.of(context).pop();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    showLoadingIndicator('Signing in..');
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential authResult =
        (await firebaseAuth.signInWithCredential(credential));
    User firebaseUser = authResult.user;
    var names = firebaseUser.displayName.split(' ');

    if (authResult.additionalUserInfo.isNewUser) {
      if (firebaseUser != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .set({
            "uid": firebaseUser.uid,
            "username": firebaseUser.displayName,
            "profilePicture": firebaseUser.photoURL == null
                ? 'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a'
                : firebaseUser.photoURL,
            "email": firebaseUser.email,
            "firstName": names[0],
            "lastName": names[1],
            "phone": firebaseUser.phoneNumber == null
                ? 'Update Your Phone Number'
                : firebaseUser.phoneNumber,
            "coverPhoto": coverphoto,
            "AadhaarUrl": 'Not Added',
            "PanUrl": 'Not Added',
            "DlUrl": 'Not Added',
            "PassportUrl": 'Not Added',
          });

          await ServiceApp.sharedPreferences.setString("uid", firebaseUser.uid);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.userEmail, firebaseUser.email);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.userAvatarUrl, firebaseUser.photoURL);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.userName, firebaseUser.displayName);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.userFirstName, names[0]);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.userLastName, names[1]);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.aadhaarUrl, 'Not Added');
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.dlUrl, 'Not Added');
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.passportUrl, 'Not Added');
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.panUrl, 'Not Added');
          await ServiceApp.sharedPreferences.setString(ServiceApp.coverUrl,
              'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a');
        } else {
          await sharedPreferences.setString("uid", documents[0]['id']);
          await sharedPreferences.setString(
              "username", documents[0]['username']);
          await sharedPreferences.setString(
              "photoURL", documents[0]['photoURL']);
        }
        print(ServiceApp.typeLogin);
        await ServiceApp.sharedPreferences
            .setString(ServiceApp.typeLogin, ServiceApp.typeLogin);

        setState(() {
          loading = false;
        });
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'Login Successful!');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ZoomDrawerr()));
        });
      } else {
        Fluttertoast.showToast(msg: "Login failed");
      }
    } else {
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.typeLogin, ServiceApp.typeLogin);
      readData(firebaseUser).then((value) {
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'Login Successful!');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ZoomDrawerr()));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 70, right: 10, left: 10),
              child: Text(
                "Verify Mobile Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Text(
                'ENTER 10 DIGIT NUMBER',
                style: TextStyle(
                  color: AppColor.c4,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  filled: true,
                  fillColor: AppColor.c2,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.c3, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.c3, width: 1.0),
                  ),
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.white,
                      height: 50,
                    )),
              ),
              Text("OR"),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.white,
                      height: 50,
                    )),
              ),
            ]),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 80, left: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      // ignore: sdk_version_set_literal
                      onTap: () => {handleSignIn()},
                      child: CircleAvatar(
                        child: Image.asset("images/google_logo.png"),
                        backgroundColor: AppColor.c1,
                      ),
                    ),
                    InkWell(
                      // ignore: sdk_version_set_literal
                      onTap: () => {
                        Fluttertoast.showToast(
                          msg: "Coming Soon",
                          fontSize: 17,
                          backgroundColor: AppColor.c1,
                        )
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("images/Facebook-01.png"),
                        backgroundColor: AppColor.c1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: AppColor.c3,
              child: IconButton(
                iconSize: 55,
                splashColor: AppColor.c4,
                icon: Icon(Icons.navigate_next_outlined),
                onPressed: () {
                  if (_controller.text == "") {
                    Fluttertoast.showToast(
                      msg: "Please Input a Number to Continue",
                      fontSize: 17,
                      backgroundColor: AppColor.c1,
                    );
                  } else {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //  builder: (context) => SignUpNew2()));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OTPScreen(_controller.text, "new")));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

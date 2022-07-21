import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:trivy/LoginPhone.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';

import 'SignUpNew2.dart';
import 'loading_indicator.dart' as loadingIndicator;
import 'trivyTech.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String type;

  OTPScreen(this.phone, this.type);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Timer _timer;
  int start = 30;
  bool wait = false;
  bool enable = false;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c1,
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.additionalUserInfo.isNewUser) {
                      showLoadingIndicator("Verifying OTP");
                      widget.type == "new"
                          ? Timer(const Duration(milliseconds: 3000), () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignUpNew2(widget.phone)),
                                  (route) => false);
                            })
                          : check();
                    } else {
                      widget.type == "new" ? check2() : check();
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          start != 0
              ? RichText(
                  text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in ",
                      style: TextStyle(fontSize: 16, color: AppColor.c3),
                    ),
                    TextSpan(
                      text: "00:$start",
                      style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                    ),
                    TextSpan(
                      text: " sec ",
                      style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                    ),
                  ],
                ))
              : RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text: "Click On Resend",
                      style: TextStyle(fontSize: 16, color: AppColor.c3)),
                  TextSpan(
                      text: "(To Get Otp Again)",
                      style: TextStyle(fontSize: 16, color: Colors.redAccent))
                ])),
          enable
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.c3,
                        fixedSize: Size(120, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => enable ? _verifyPhone() : null,
                      child: Text(
                        "Resend",
                        style: TextStyle(fontSize: 20),
                      )),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.c3,
                        fixedSize: Size(120, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: null,
                      child: Text(
                        "Resend",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
        ],
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          enable = true;
          timer.cancel();
          wait = false;
        });
      } else {
        if (this.mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  void check2() async {
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((dataSnapshot) async {
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.userUID, dataSnapshot.get(ServiceApp.userUID));
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
    showLoadingIndicator('Verifying OTP');
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ZoomDrawerr()),
          (route) => false);
      Fluttertoast.showToast(
        msg: "Welcome Back!",
        fontSize: 17,
        backgroundColor: AppColor.c1,
      );
    });
  }

  _verifyPhone() async {
    setState(() {
      start = 30;
      enable = false;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            showLoadingIndicator('Verifying OTP');
            if (value.additionalUserInfo.isNewUser) {
              widget.type == "new"
                  ? new Timer(const Duration(milliseconds: 2000), () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpNew2(widget.phone)),
                          (route) => false);
                    })
                  : check();
            } else {
              widget.type == "new" ? check2() : check();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
            msg: e.message,
            fontSize: 17,
            backgroundColor: AppColor.c1,
          );
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
          Fluttertoast.showToast(
            msg: "Otp Sent",
            fontSize: 17,
            backgroundColor: AppColor.c1,
          );
          startTimer();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 30));
  }

  bool exist;
  Future check() async {
    print('incheck_1');
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    try {
      await FirebaseFirestore.instance.doc("users/$uid").get().then((doc) {
        exist = doc.exists;
      });
      if (exist) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((dataSnapshot) async {
          await ServiceApp.sharedPreferences
              .setString("uid", dataSnapshot.get(ServiceApp.userUID));
          await ServiceApp.sharedPreferences.setString(
              ServiceApp.userEmail, dataSnapshot.get(ServiceApp.userEmail));
          await ServiceApp.sharedPreferences.setString(ServiceApp.userFirstName,
              dataSnapshot.get(ServiceApp.userFirstName));
          await ServiceApp.sharedPreferences.setString(ServiceApp.userLastName,
              dataSnapshot.get(ServiceApp.userLastName));
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
          await ServiceApp.sharedPreferences.setString(ServiceApp.panUrl,
              dataSnapshot.get(ServiceApp.panUrl).toString());
          //print(dataSnapshot.get('profilePicture').toString());
        });
        showLoadingIndicator('Verifying OTP');
        Timer(const Duration(milliseconds: 2000), () {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "Welcome Back",
            fontSize: 17,
            backgroundColor: AppColor.c1,
            gravity: ToastGravity.CENTER,
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ZoomDrawerr()),
              (route) => false);
        });
      } else {
        user.delete();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPagePhone()),
            (route) => false);
        Fluttertoast.showToast(
            msg: "Account Does Not Exist(Create a New Account)",
            fontSize: 17,
            backgroundColor: AppColor.c1,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      // If any error
      return false;
    }
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
              content: loadingIndicator.LoadingIndicator(text: text),
            ));
      },
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}

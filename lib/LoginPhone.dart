import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/Otp.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/loading_indicator.dart' as loadingindi;

import 'SignUpNew.dart';
import 'trivyTech.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
bool loading = false;
bool isLoggedIn = false;
// ignore: unused_element
String _email, _password;
SharedPreferences sharedPreferences;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

// ignore: must_be_immutable
class LoginPagePhone extends StatefulWidget {
  static const String id = 'loginpage';

  @override
  _LoginPagePhoneState createState() => _LoginPagePhoneState();
}

class _LoginPagePhoneState extends State<LoginPagePhone> {
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
          Navigator.pop(context);
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
              content: loadingindi.LoadingIndicator(text: text),
            ));
      },
    );
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
      await ServiceApp.sharedPreferences.setString(
          ServiceApp.aadhaarUrl, dataSnapshot.get(ServiceApp.aadhaarUrl));
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.dlUrl, dataSnapshot.get(ServiceApp.dlUrl));
      await ServiceApp.sharedPreferences.setString(
          ServiceApp.passportUrl, dataSnapshot.get(ServiceApp.passportUrl));
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.panUrl, dataSnapshot.get(ServiceApp.panUrl));

      //print(dataSnapshot.get('profilePicture').toString());
    });
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  final _key = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Center(
        child: Scaffold(
          backgroundColor: AppColor.c1,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  /*  Image(
                    //image: NetworkImage(
                     //   ''),
                    fit: BoxFit.cover,
                    color: Colors.black87,
                    colorBlendMode: BlendMode.darken,
                  ),*/
                  Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        "Login With Phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0),
                    child: FormBuilder(
                      // autovalidate: true,
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Form(
                              key: _key,
                              child: Theme(
                                data: ThemeData(
                                  brightness: Brightness.light,
                                  primaryColor: AppColor.c2,
                                  inputDecorationTheme: InputDecorationTheme(
                                    labelStyle: TextStyle(
                                      color: AppColor.c2,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FormBuilderTextField(
                                        maxLength: 10,
                                        attribute: 'phone',
                                        controller: _phoneController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                        ],
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone),
                                          filled: true,
                                          fillColor: AppColor.c2,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.c2, width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.c2, width: 1.0),
                                          ),
                                          labelStyle: TextStyle(
                                            color: AppColor.c2,
                                          ),
                                          labelText: 'Enter PhoneNo',
                                          focusColor: AppColor.c2,
                                          prefixText: "+91",
                                        ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 80.0, right: 80.0),
                              child: MaterialButton(
                                minWidth: 200,
                                height: 52.0,
                                elevation: 5.0,
                                color: AppColor.c3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  _phoneController.text.isNotEmpty
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  OTPScreen(
                                                      _phoneController.text,
                                                      "old")))
                                      : showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Please Enter Phone Number'),
                                            );
                                          });
                                  //Navigator.pushNamed(context, MyAccount.id);
                                },
                                child: const Text(
                                  'LOGIN',
                                  // style: TextStyle(
                                  // ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 100.0, right: 80.0),
                              child: Row(
                                children: [
                                  AutoSizeText("Don't Have an Account?",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColor.c2, fontSize: 10)),
                                  InkWell(
                                      // ignore: sdk_version_set_literal
                                      onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUp()))
                                          },
                                      child: AutoSizeText(
                                        "SignUp",
                                        style: TextStyle(
                                            color: AppColor.c2, fontSize: 10),
                                        maxLines: 1,
                                      ))
                                ],
                              ),
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                              ),
                              Text("OR"),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                              ),
                            ]),
                            Container(
                              height: SizeConfig.blockSizeVertical * 8,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 80, left: 80, top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      // ignore: sdk_version_set_literal
                                      onTap: () => {handleSignIn()},
                                      child: CircleAvatar(
                                        child: Image.asset(
                                            "images/google_logo.png"),
                                        backgroundColor: AppColor.c1,
                                      ),
                                    ),
                                    InkWell(
                                      // ignore: sdk_version_set_literal
                                      onTap: () => {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Coming Soon'),
                                              );
                                            })
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            "images/Facebook-01.png"),
                                        backgroundColor: AppColor.c1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  void reset() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ZoomDrawerr();
    }));
  }
}

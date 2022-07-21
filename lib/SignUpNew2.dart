import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trivy/DocumentsUpload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trivy/Otp.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class SignUpNew2 extends StatefulWidget {
  final String phone;
  SignUpNew2(this.phone);
  @override
  _SignUpNew2State createState() => _SignUpNew2State();
}

class _SignUpNew2State extends State<SignUpNew2> {
  
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c1,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70, right: 120),
                    child: Text(
                      "Create Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: FormBuilderTextField(
                      attribute: 'email',
                      controller: _emailController,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail_outline,
                        ),
                        filled: true,
                        fillColor: AppColor.c2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 1.0),
                        ),
                        labelStyle: TextStyle(
                          color: AppColor.c4,
                        ),
                        labelText: 'Enter E-Mail ID',
                        focusColor: AppColor.c4,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: FormBuilderTextField(
                      attribute: 'firstname',
                      controller: _firstnameController,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: AppColor.c2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 1.0),
                        ),
                        labelStyle: TextStyle(
                          color: AppColor.c4,
                        ),
                        labelText: 'Enter First Name',
                        focusColor: AppColor.c4,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: FormBuilderTextField(
                      attribute: 'lastname',
                      controller: _lastnameController,
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: AppColor.c2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 1.0),
                        ),
                        labelStyle: TextStyle(
                          color: AppColor.c4,
                        ),
                        labelText: 'Enter Last Name',
                        focusColor: AppColor.c4,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: FormBuilderTextField(
                      attribute: 'password',
                      controller: _passwordController,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: AppColor.c2,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.c3, width: 1.0),
                        ),
                        labelStyle: TextStyle(
                          color: AppColor.c4,
                        ),
                        labelText: 'Password',
                        focusColor: AppColor.c4,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
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
                    if (_emailController.text.isEmpty ||
                        _firstnameController.text.isEmpty ||
                        _lastnameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Fill out All Details",
                        fontSize: 17,
                        backgroundColor: AppColor.c1,
                      );
                    } else {
                      registerUser();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential uc;
  void registerUser() async {
    User userPhone = FirebaseAuth.instance.currentUser;
    if (userPhone != null) {
      try {
        print('Phone Number${userPhone.phoneNumber}');
        AuthCredential credential = EmailAuthProvider.credential(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        uc = await userPhone.linkWithCredential(credential);
        if (uc != null) {
          print(uc);
          saveUser(userPhone);
          await ServiceApp.sharedPreferences
              .setString(ServiceApp.typeLogin, "");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return DocumentsUpload();
          }));
        }
      } on FirebaseException catch (e) {
        if (e.message ==
            "The email address is already in use by another account.") {
          print(e.message);
          Fluttertoast.showToast(
            msg: "Email Already Linked Try Other Email",
            fontSize: 17,
            backgroundColor: AppColor.c1,
          );
        } else {
          print(e.message);
          Fluttertoast.showToast(
            msg: "System Error",
            fontSize: 17,
            backgroundColor: AppColor.c1,
          );
        }
      }
    }
  }

  Future saveUser(User user) async {
    await ServiceApp.sharedPreferences.setString(ServiceApp.userUID, user.uid);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userEmail, _emailController.text);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userFirstName, _firstnameController.text);
    await ServiceApp.sharedPreferences.setString(ServiceApp.userAvatarUrl,
        "https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a");
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userLastName, _lastnameController.text);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userPhone, widget.phone.toString());
    await ServiceApp.sharedPreferences.setString(ServiceApp.coverUrl,
        ServiceApp.sharedPreferences.getString(ServiceApp.userAvatarUrl));
    await ServiceApp.sharedPreferences.setString(ServiceApp.typeLogin, '');
  }
}

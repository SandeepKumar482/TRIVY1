import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/api/firebase_api.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/onboarding_page.dart';
import 'package:trivy/trivyTech.dart';

import 'loading_indicator.dart' as newindicator;

class DocumentsUpload extends StatefulWidget {
  @override
  _DocumentsUploadState createState() => _DocumentsUploadState();
}

class _DocumentsUploadState extends State<DocumentsUpload> {
  TextEditingController _addharcard = TextEditingController();
  TextEditingController _dl = TextEditingController();
  TextEditingController _pan = TextEditingController();
  TextEditingController _passport = TextEditingController();
  String _aadhaarDown = "Not Added";
  String _panDown = "Not Added";
  String _dlDown = "Not Added";
  String _passDown = "Not Added";
  String _picDown = "";

  String uid;
  UploadTask task;
  File file;
  ImagePicker picker = ImagePicker();
  PickedFile image;

  @override
  void initState() {
    super.initState();
    _picDown =
        "https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a";
    uid = FirebaseAuth.instance.currentUser.uid;
  }

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
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text(
                      "Verify Documents",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColor.c2, width: 2.0)),
                            child: CircleAvatar(
                              backgroundImage: image == null
                                  ? NetworkImage(_picDown)
                                  : FileImage(File(image.path)),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: AppColor.c2,
                                    context: context,
                                    builder: ((builder) =>
                                        bottomSheet(context)));
                              },
                              child: Icon(Icons.camera_alt,
                                  size: 20, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _addharcard,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c2,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c2,
                              ),
                              hintText: 'Add Aadhaar Card',
                              focusColor: AppColor.c2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.c3,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                              ),
                            ),
                            onPressed: () {
                              selectFileAadhaar(context);
                            },
                            child: Icon(Icons.attach_file),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _passport,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c2,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c2,
                              ),
                              hintText: 'Add Passport',
                              focusColor: AppColor.c2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.c3,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              selectFilePassport(context);
                            },
                            child: Icon(Icons.attach_file),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _dl,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c2,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c1, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c1, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c2,
                              ),
                              hintText: 'Add Driving Licence',
                              focusColor: AppColor.c2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.c3,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              selectFileDl(context);
                            },
                            child: Icon(Icons.attach_file),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _pan,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c2,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c2, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c2,
                              ),
                              hintText: 'Add Pan Card',
                              focusColor: AppColor.c2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.c3,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              selectFilePan(context);
                            },
                            child: Icon(Icons.attach_file),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 40,
                  right: MediaQuery.of(context).size.width / 10 * .2,
                  left: MediaQuery.of(context).size.width / 10 * .4),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10 * .2,
                          right: MediaQuery.of(context).size.width / 10 * 3.2),
                      child: InkWell(
                        onTap: () {
                          showLoadingIndicator2(
                              'Creating User Account', context);
                          updateRecordsSkip();
                          Timer(const Duration(milliseconds: 2000), () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ZoomDrawerr()));
                          });
                        },
                        child: Container(
                            height:
                                MediaQuery.of(context).size.height / 10 * .6,
                            width: MediaQuery.of(context).size.width / 10 * 2.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 3, color: AppColor.c3),
                            ),
                            child: Center(
                                child: Text(
                              "Skip",
                              style:
                                  TextStyle(color: AppColor.c3, fontSize: 20),
                              textAlign: TextAlign.center,
                            ))),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.c3,
                        fixedSize: Size(120, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        showLoadingIndicator2('Creating User Account', context);
                        updateRecords();
                        Timer(const Duration(milliseconds: 2000), () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OnBoardingPage()));
                        });
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLoadingIndicator2([String text, BuildContext context]) {
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
              content: newindicator.LoadingIndicator(text: text),
            ));
      },
    );
  }

  Future selectFileAadhaar(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
      final fileName = file != null ? basename(file.path) : 'No File Selected';
      _addharcard.value = TextEditingValue(
        text: fileName,
      );
    });
// Upload File to FireBase Storage //Start
    uploadFile("aadhaar", context);
    // Upload File to FireBase Storage //End
    showLoadingIndicator(
        'Uploading', 'Please Wait', context, buildUploadStatus(task));
  }

  Future selectFilePassport(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
      final fileName = file != null ? basename(file.path) : 'No File Selected';
      _passport.value = TextEditingValue(
        text: fileName,
      );
    });

    uploadFile("passport", context);
    showLoadingIndicator(
        'Uploading', 'Please Wait', context, buildUploadStatus(task));
  }

  Future selectFilePan(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
      final fileName = file != null ? basename(file.path) : 'No File Selected';
      _pan.value = TextEditingValue(
        text: fileName,
      );
    });

    uploadFile("pan", context);
    showLoadingIndicator(
        'Uploading', 'Please Wait', context, buildUploadStatus(task));
  }

  Future selectFileDl(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
      final fileName = file != null ? basename(file.path) : 'No File Selected';
      _dl.value = TextEditingValue(
        text: fileName,
      );
    });

    uploadFile("dl", context);
    showLoadingIndicator(
        'Uploading', 'Please Wait', context, buildUploadStatus(task));
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

  Future uploadFile(String doctype, BuildContext context) async {
    if (doctype == "aadhaar") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {});

      if (task == null) return;

      final snapshot = await task.whenComplete(() {});

      _aadhaarDown = await snapshot.ref.getDownloadURL();
      print('Download-Link(Aadhaar): $_aadhaarDown');
      Navigator.of(context).pop();
    }
    if (doctype == "dl") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {});

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _dlDown = await snapshot.ref.getDownloadURL();
      print('Download-Link(DL): $_dlDown');
      Navigator.of(context).pop();
    }
    if (doctype == "pan") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {});

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _panDown = await snapshot.ref.getDownloadURL();
      print('Download-Link(PanCard): $_panDown');
      Navigator.of(context).pop();
    }
    if (doctype == "passport") {
      if (file == null) return;
      // final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {});

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _passDown = await snapshot.ref.getDownloadURL();
      print('Download-Link(Passport): $_passDown');
      Navigator.of(context).pop();
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;

            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            );
          } else {
            return Text("Starting..");
          }
        },
      );
  Future updateRecords() async {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "uid": ServiceApp.sharedPreferences.getString(ServiceApp.userUID),
      "email": ServiceApp.sharedPreferences.getString(ServiceApp.userEmail),
      "firstName":
          ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName),
      "lastName":
          ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      "phone": ServiceApp.sharedPreferences.getString(ServiceApp.userPhone),
      "username":
          ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName) +
              " " +
              ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      'coverPhoto':
          'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a',
      "AadhaarUrl": _aadhaarDown,
      "PanUrl": _panDown,
      "DlUrl": _dlDown,
      "PassportUrl": _passDown,
      "profilePicture": _picDown,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
    readData(FirebaseAuth.instance.currentUser);
  }

  Future updateRecordsSkip() async {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "uid": ServiceApp.sharedPreferences.getString(ServiceApp.userUID),
      "email": ServiceApp.sharedPreferences.getString(ServiceApp.userEmail),
      "firstName":
          ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName),
      "lastName":
          ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      "phone": ServiceApp.sharedPreferences.getString(ServiceApp.userPhone),
      "username":
          ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName) +
              " " +
              ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      'coverPhoto':
          'https://firebasestorage.googleapis.com/v0/b/trivy-da737.appspot.com/o/important%2Fprofile.png?alt=media&token=308c6e56-c7bb-4698-95a7-9053ed50b76a',
      "AadhaarUrl": "Not Added",
      "PanUrl": "Not Added",
      "DlUrl": "Not Added",
      "PassportUrl": "Not Added",
      "profilePicture": _picDown,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
    readData(FirebaseAuth.instance.currentUser);
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

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text(
                    'Camera',
                    style: TextStyle(fontSize: 12),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 12),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      image = null;
                    });
                  },
                  icon: Icon(Icons.clear),
                  label: Text(
                    'Remove',
                    style: TextStyle(fontSize: 12),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      image = pickedFile;
    });
    if (image == null) return;

    // final fileName = basename(image.path.split('/').last);
    final destination = uid + '/profilePic';
    print(destination);
    task = FirebaseApi.uploadFile(destination, File(image.path));
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});

    _picDown = await snapshot.ref.getDownloadURL();
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userAvatarUrl, _picDown);
    print('Download-Link(ProfilePhoto): $_picDown');
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text = '', this.head = 'Please Wait..', this.widget});

  final String text;
  final String head;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    var displayedText = text;
    var heading = head;
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87.withOpacity(0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context, heading),
              _getText(displayedText),
              widget,
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child:
                CircularProgressIndicator(color: AppColor.c3, strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context, heading) {
    return Padding(
        child: Text(
          heading,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}

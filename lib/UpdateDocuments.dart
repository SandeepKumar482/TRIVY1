import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:trivy/api/firebase_api.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

import 'ZoomDrawer.dart';
import 'loading_indicator.dart' as loadingindicator;

class UpdateDocs extends StatefulWidget {
  static final id = 'updateDocs';
  @override
  _UpdateDocsState createState() => _UpdateDocsState();
}

class _UpdateDocsState extends State<UpdateDocs> {
  static TextEditingController _addharcard = TextEditingController();
  static TextEditingController _dl = TextEditingController();
  static TextEditingController _pan = TextEditingController();
  static TextEditingController _passport = TextEditingController();
  String _aadhaarDown = "Not Added";
  String _panDown = "Not Added";
  String _dlDown = "Not Added";
  String _passDown = "Not Added";

  String adharTextFile;
  String passportTextFile;
  String dlTextFile;
  String panCardTextFile;

  String uid;
  UploadTask task;
  File file;

  //Icon attach=Icon(Icons.attach_file_outlined);
  static Widget adChild = Icon(Icons.attach_file_outlined);
  static Widget panChild = Icon(Icons.attach_file_outlined);
  static Widget dlChild = Icon(Icons.attach_file_outlined);
  static Widget pasChild = Icon(Icons.attach_file_outlined);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
    _addharcard.value =
        (ServiceApp.sharedPreferences.getString(ServiceApp.aadhaarUrl) !=
                "Not Added"
            ? TextEditingValue(text: 'Adhaar Card uploaded')
            : TextEditingValue(text: 'Upload Adhaar Card '));
    _pan.value = (ServiceApp.sharedPreferences.getString(ServiceApp.panUrl) !=
            "Not Added"
        ? TextEditingValue(text: 'PAN Card uploaded')
        : TextEditingValue(text: 'Upload PAN Card'));
    _dl.value =
        (ServiceApp.sharedPreferences.getString(ServiceApp.dlUrl) != "Not Added"
            ? TextEditingValue(text: 'Driving License uploaded')
            : TextEditingValue(text: 'Upload Driving License'));
    _passport.value =
        (ServiceApp.sharedPreferences.getString(ServiceApp.passportUrl) !=
                "Not Added"
            ? TextEditingValue(text: 'Passport uploaded')
            : TextEditingValue(text: 'Upload Passport'));

    adChild =
        _addharcard.value == TextEditingValue(text: 'Adhaar Card uploaded')
            ? Text(
                'Under Verification',
                style: TextStyle(color: AppColor.c1),
              )
            : Icon(Icons.attach_file_outlined);

    panChild = _pan.value == TextEditingValue(text: 'PAN Card uploaded')
        ? Text(
            'Under Verification',
            style: TextStyle(color: AppColor.c1),
          )
        : Icon(Icons.attach_file_outlined);

    dlChild = _dl.value == TextEditingValue(text: 'Driving License uploaded')
        ? Text(
            'Under Verification',
            style: TextStyle(color: AppColor.c1),
          )
        : Icon(Icons.attach_file_outlined);

    pasChild = _passport.value == TextEditingValue(text: 'Passport uploaded')
        ? Text(
            'Under Verification',
            style: TextStyle(color: AppColor.c1),
          )
        : Icon(Icons.attach_file_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c5,
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
                      "Update Documents",
                      style: TextStyle(
                        color: AppColor.c1,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _addharcard,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c3,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c4,
                              ),
                              hintText: 'Add Aadhaar Card',
                              focusColor: AppColor.c4,
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
                            child: adChild,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 18.0, left: 65.0, right: 65.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColor.c4,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _passport,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c3,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c4,
                              ),
                              hintText: 'Add Passport',
                              focusColor: AppColor.c4,
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
                            child: pasChild,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 18.0, left: 65.0, right: 65.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColor.c4,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _dl,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c3,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c4,
                              ),
                              hintText: 'Add Driving Licence',
                              focusColor: AppColor.c4,
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
                            child: dlChild,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 18.0, left: 65.0, right: 65.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColor.c4,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColor.c4,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: _pan,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.document_scanner,
                                color: AppColor.c3,
                              ),
                              filled: true,
                              fillColor: AppColor.c2,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.c3, width: 1.0),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor.c4,
                              ),
                              hintText: 'Add Pan Card',
                              focusColor: AppColor.c4,
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
                            child: panChild,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "*Don't Add Document if it is Already Added",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.c3,
                    fixedSize: Size(120, 50),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showLoadingIndicator2("Updating Records", context);
                    updateRecords();
                    Timer(const Duration(milliseconds: 2000), () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ZoomDrawerr()));
                    });
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
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

  void showLoadingIndicator2([String text, BuildContext context]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87.withOpacity(0.8),
              content: loadingindicator.LoadingIndicator(text: text),
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

  Future uploadFile(String doctype, BuildContext context) async {
    if (doctype == "aadhaar") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {
        adChild = Text(
          'Under Verification',
          style: TextStyle(color: AppColor.c1),
        );
      });

      if (task == null) return;

      final snapshot = await task.whenComplete(() {});

      _aadhaarDown = await snapshot.ref.getDownloadURL();
      // ServiceApp.sharedPreferences.setString('AadhaarUrl', _aadhaarDown);
      print('Download-Link(Aadhaar): $_aadhaarDown');
      Navigator.of(context).pop();
    }
    if (doctype == "dl") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {
        dlChild = Text(
          'Under Verification',
          style: TextStyle(color: AppColor.c1),
        );
      });

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _dlDown = await snapshot.ref.getDownloadURL();
      // ServiceApp.sharedPreferences.setString('dlUrl', _dlDown);
      print('Download-Link(DL): $_dlDown');
      Navigator.of(context).pop();
    }
    if (doctype == "pan") {
      if (file == null) return;
      //final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);
      setState(() {
        panChild = Text(
          'Under Verification',
          style: TextStyle(color: AppColor.c1),
        );
      });

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _panDown = await snapshot.ref.getDownloadURL();
      // ServiceApp.sharedPreferences.setString('panUrl', _panDown);
      print('Download-Link(PanCard): $_panDown');
      Navigator.of(context).pop();
    }
    if (doctype == "passport") {
      if (file == null) return;
      // final fileName = basename(file.path);
      final destination = uid + '/$doctype';
      print(destination);
      task = FirebaseApi.uploadFile(destination, file);

      setState(() {
        pasChild = Text(
          'Under Verification',
          style: TextStyle(color: AppColor.c1),
        );
      });

      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      _passDown = await snapshot.ref.getDownloadURL();
      // ServiceApp.sharedPreferences.setString('passUrl', _passDown);
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
                  fontWeight: FontWeight.bold),
            );
          } else {
            return Text("Starting..");
          }
        },
      );
  Future updateRecords() async {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "AadhaarUrl": _aadhaarDown,
      "PanUrl": _panDown,
      "DlUrl": _dlDown,
      "PassportUrl": _passDown,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.aadhaarUrl, _aadhaarDown);
    await ServiceApp.sharedPreferences.setString(ServiceApp.panUrl, _panDown);
    await ServiceApp.sharedPreferences.setString(ServiceApp.dlUrl, _dlDown);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.passportUrl, _passDown);
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

  Widget _getText(String displayedText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        displayedText,
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}

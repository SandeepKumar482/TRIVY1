import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

import 'api/firebase_api.dart';
import 'loading_indicator.dart' as loadingindicator;

class EditProfile extends StatefulWidget {
  static const String id = 'EditProf';

  @override
  _EditProfileState createState() => _EditProfileState();
}

// final FirebaseAuth _auth = FirebaseAuth.instance
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
bool loading = false;
bool isLoggedIn = false;
String _profileDown = '';
// String _email, _password;
SharedPreferences sharedPreferences;

class _EditProfileState extends State<EditProfile> {
  ImagePicker picker = ImagePicker();
  PickedFile image;
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phone = TextEditingController();

  Widget bottomSheet() {
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
                  label: Text('Camera')),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      image = null;
                    });
                  },
                  icon: Icon(Icons.clear),
                  label: Text('Remove'))
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
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

    _profileDown = await snapshot.ref.getDownloadURL();
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userAvatarUrl, _profileDown);
    print('Download-Link(ProfilePhoto): $_profileDown');
    updateProfileP();
  }

  Future updateProfileP() async {
    await firestore.FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({
      "profilePicture": _profileDown,
    }, firestore.SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  Widget nameField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      controller: name,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.c4,
            ),
          ),
          prefixIcon: Icon(
            Icons.person,
            color: AppColor.c3,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.c2, width: 2),
          ),
          labelText: 'Name',
          hintText: 'Enter new name'),
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      controller: email,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.c4,
            ),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: AppColor.c3,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.c2, width: 2),
          ),
          labelText: 'Email',
          hintText: 'Enter new email'),
    );
  }

  DateTime date;
  DateTime intialDate = DateTime.now();
  var myFormat = DateFormat('d-MM-yyyy');
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: intialDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    setState(() {
      date = picked ?? date;
      dob.text = myFormat.format(date);
    });
  }

  Widget dobField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: IgnorePointer(
        child: TextFormField(
          // initialValue: intialDate.toString(),
          controller: dob,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.c4,
              ),
            ),
            prefixIcon: Icon(
              Icons.date_range,
              color: AppColor.c3,
            ),
            hintText: date != null ? '${myFormat.format(date)}' : 'DOB',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.c2, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      controller: phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.c4,
            ),
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: AppColor.c3,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.c2, width: 2),
          ),
          labelText: 'Phone Number',
          hintText: 'Enter new number'),
    );
  }

  Future updateProfile() async {
    var names = name.text.split(' ');
    firestore.FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": email.text.isNotEmpty
          ? email.text
          : ServiceApp.sharedPreferences.getString(ServiceApp.userEmail),
      "firstName": name.text.isNotEmpty
          ? names[0]
          : ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName),
      "lastName": name.text.isNotEmpty
          ? names[1]
          : ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      "phone": phone.text.isNotEmpty
          ? phone.text
          : ServiceApp.sharedPreferences.getString(ServiceApp.userPhone),
      "username": name.text.isNotEmpty
          ? name.text
          : ServiceApp.sharedPreferences.getString(ServiceApp.userFirstName) +
              " " +
              ServiceApp.sharedPreferences.getString(ServiceApp.userLastName),
      "Dob": dob.text.isNotEmpty ? myFormat.format(date) : 'Update Dob',
    }, firestore.SetOptions(merge: true)).then((_) {
      print("success!");
    });
    readData(FirebaseAuth.instance.currentUser);
  }

  Future readData(User user) async {
    firestore.FirebaseFirestore.instance
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _key,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: NetworkImage(
                      'https://www.centromundolengua.com/wp-content/uploads/2018/02/international-travel-guide-getting-through-the-airport-minors-traveling-alone-first-time-travelers-study-abroad-spain-centro-mundolengua.jpg'),
                  fit: BoxFit.cover,
                  color: Colors.black87,
                  colorBlendMode: BlendMode.darken,
                ),
                ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  children: [
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        Stack(
//                          children: [
//                            Container(
//                              width: 100,
//                              height: 100,
//                              decoration: BoxDecoration(
//                                  shape: BoxShape.circle,
//                                  border: Border.all(color: AppColor.c2, width: 2.0)),
//                              child: CircleAvatar(
//                                backgroundImage: image == null
//                                    ? NetworkImage(
//                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
//                                    : FileImage(File(image.path)),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 10,
//                              right: 20,
//                              child: InkWell(
//                                onTap: () {
//                                  showModalBottomSheet(
//                                      backgroundColor: AppColor.c2,
//                                      context: context,
//                                      builder: ((builder) => bottomSheet()));
//                                },
//                                child: Icon(Icons.camera_alt,
//                                    size: 20, color: Colors.grey),
//                              ),
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: AppColor.c3,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    nameField(),
                    SizedBox(
                      height: 30,
                    ),
                    emailField(),
                    SizedBox(
                      height: 30,
                    ),
                    dobField(),
                    SizedBox(
                      height: 30,
                    ),
                    phoneField(),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        if (email.text.isNotEmpty)
                          await ServiceApp.sharedPreferences
                              .setString(ServiceApp.userEmail, email.text);
                        if (dob.text.isNotEmpty)
                          await ServiceApp.sharedPreferences
                              .setString(ServiceApp.dob, myFormat.format(date));
                        if (name.text.isNotEmpty) {
                          print(name);
                          var names = name.text.split(' ');
                          await ServiceApp.sharedPreferences
                              .setString(ServiceApp.userFirstName, names[0]);
                          await ServiceApp.sharedPreferences
                              .setString(ServiceApp.userLastName, names[1]);
                        }
                        if (phone.text.isNotEmpty) {
                          await ServiceApp.sharedPreferences
                              .setString(ServiceApp.userPhone, phone.text);
                        }
                        updateProfile();
                        showLoadingIndicator2('Updating Records', context);
                        Timer(const Duration(milliseconds: 3000), () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Profile();
                          }));
                        });
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColor.c3,
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: AppColor.c4,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
            content: loadingindicator.LoadingIndicator(text: text),
          ));
    },
  );
}
//backgroundColor: AppColor.c1,
//        appBar: AppBar(
//          iconTheme: IconThemeData(
//            color: Color(0xffeeeeee),
//          ),
//          title: Center(child: Text('Edit Profile')),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.settings),
//              onPressed: () {
//                Navigator.pushNamed(context, Settings.id);
//              },
//            )
//          ],
//          elevation: 0,
//          backgroundColor: Color(0xff232931),
//          brightness: Brightness.dark,
//          textTheme: TextTheme(
//              title: TextStyle(
//            color: AppColor.c4,
//            fontSize: 20,
//          )),
//        ),
//        drawer: Drawer(
//          child: Container(
//            color: AppColor.c1,
//            child: ListView(
//              children: <Widget>[
//                UserAccountsDrawerHeader(
//                  decoration: BoxDecoration(
//                    color: AppColor.c3,
//                  ),
//                  accountName: Text(
//                    'Pulkit Agarwal',
//                    style: TextStyle(
//                      color: AppColor.c2,
//                      fontSize: 16.0,
//                    ),
//                  ),
//                  accountEmail: Text(
//                    'pulkitagarwal2899@gmail.com',
//                    style: TextStyle(
//                      color: AppColor.c2,
//                      fontSize: 16.0,
//                    ),
//                  ),
//                  currentAccountPicture: CircleAvatar(
//                    backgroundColor: AppColor.c4,
//                    child: Text('P'),
//                  ),
//                ),
//                ListTile(
//                  title: Text('Home'),
//                  leading: Icon(Icons.home),
//                  onTap: () {
//                    Navigator.pushNamed(context, MyAccount.id);
//                  },
//                ),
//                Divider(
//                  color: AppColor.c4,
//                ),
//                ListTile(
//                  title: Text('My Profile'),
//                  leading: Icon(Icons.account_circle),
//                  onTap: () {
//                    Navigator.pushNamed(context, Profile.id);
//                  },
//                ),
//                ListTile(
//                  title: Text('My Trips'),
//                  leading: Icon(Icons.flight),
//                  onTap: () {
//                    Navigator.pushNamed(context, MyTrips.id);
//                  },
//                ),
//                ListTile(
//                  title: Text('My Wallet'),
//                  leading: Icon(Icons.account_balance_wallet),
//                  onTap: () {
//                    Navigator.pushNamed(context, Wallet.id);
//                  },
//                ),
//                Divider(
//                  color: AppColor.c4,
//                ),
//                ListTile(
//                  title: Text('How We Work'),
//                  leading: Icon(Icons.info),
//                  onTap: () {
//                    Navigator.pushNamed(context, How.id);
//                  },
//                ),
//                ListTile(
//                  title: Text('Help & Support'),
//                  leading: Icon(Icons.help),
//                  onTap: () {
//                    Navigator.pushNamed(context, Help.id);
//                  },
//                ),
//                ListTile(
//                  title: Text('About Us'),
//                  leading: Icon(Icons.info),
//                  onTap: () {
//                    Navigator.pushNamed(context, About.id);
//                  },
//                ),
//                ListTile(
//                  title: Text('Contact Us'),
//                  leading: Icon(Icons.question_answer),
//                  onTap: () {
//                    Navigator.pushNamed(context, Contact.id);
//                  },
//                ),
//                Divider(
//                  color: AppColor.c4,
//                ),
//                ListTile(
//                  title: Text('Terms & Conditions'),
//                  leading: Icon(Icons.content_paste),
//                  onTap: () {
//                    Navigator.pushNamed(context, Terms.id);
//                  },
//                ),
//                Divider(
//                  color: AppColor.c4,
//                ),
//                ListTile(
//                  title: Text('Log Out'),
//                  leading: Icon(Icons.exit_to_app),
//                  onTap: () {
//                    Navigator.pushNamed(context, LoginPage.id);
//                  },
//                ),
//              ],
//            ),
//          ),
//        ),

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/loginpage.dart';
import 'package:trivy/onboarding_page.dart';
import 'package:trivy/trivyTech.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
bool loading = false;
bool isLoggedIn = false;
//String _email, _password;
SharedPreferences sharedPreferences;

class SignUpPage extends StatefulWidget {
  static const String id = 'signuppage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ZoomDrawerr()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      var names = firebaseUser.displayName.split(' ');
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
          "profilePicture": firebaseUser.photoURL,
          "email": firebaseUser.email,
          "firstName": names[0],
          "lastName": names[1],
          "phone": firebaseUser.phoneNumber,
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

        // await sharedPreferences.setString("name", firebaseUser.displayName);
        // await sharedPreferences.setString("photoURL", firebaseUser.displayName);
      } else {
        await sharedPreferences.setString("uid", documents[0]['id']);
        await sharedPreferences.setString("username", documents[0]['username']);
        await sharedPreferences.setString("photoURL", documents[0]['photoURL']);
      }
      Fluttertoast.showToast(msg: 'SignUp Successful!');
      setState(() {
        loading = false;
      });
      await ServiceApp.sharedPreferences
          .setString(ServiceApp.typeLogin, "google");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  final _key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(
                        'https://www.centromundolengua.com/wp-content/uploads/2018/02/international-travel-guide-getting-through-the-airport-minors-traveling-alone-first-time-travelers-study-abroad-spain-centro-mundolengua.jpg'),
                    fit: BoxFit.cover,
                    color: Colors.black87,
                    colorBlendMode: BlendMode.darken,
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: FormBuilder(
                      //autovalidateMode:,
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Form(
                              key: _key,
                              child: Theme(
                                data: ThemeData(
                                  brightness: Brightness.dark,
                                  primaryColor: AppColor.c4,
                                  inputDecorationTheme: InputDecorationTheme(
                                    labelStyle: TextStyle(
                                      color: AppColor.c4,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FormBuilderTextField(
                                        controller: _firstNameController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'First Name',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType: TextInputType.text,
                                        attribute: null,
                                      ),
                                      FormBuilderTextField(
                                        controller: _lastNameController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'Last Name',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType: TextInputType.text,
                                        attribute: null,
                                      ),
                                      FormBuilderTextField(
                                        controller: _phoneController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.numeric()
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'Mobile Number',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        attribute: null,
                                      ),
                                      FormBuilderTextField(
                                        controller: _emailController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.email(),
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'Enter E-Mail ID',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        attribute: null,
                                      ),
                                      FormBuilderTextField(
                                        controller: _passwordController,
                                        validators: [
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(6),
                                          FormBuilderValidators.maxLength(12),
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'Password',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        maxLines: 1,
                                        attribute: null,
                                      ),
                                      FormBuilderTextField(
                                        controller: _confirmPasswordController,
                                        validators: [],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: AppColor.c4,
                                          ),
                                          labelText: 'Confirm Password',
                                          focusColor: AppColor.c4,
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        maxLines: 1,
                                        attribute: null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 80.0, right: 80.0),
                              child: MaterialButton(
                                minWidth: 200,
                                height: 52.0,
                                elevation: 5.0,
                                color: AppColor.c3,
                                onPressed: () {
                                  registerUser();
                                },
                                child: const Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 80.0, right: 80.0),
                              child: Row(
                                children: [
                                  AutoSizeText("Already Have An Account?",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: AppColor.c4, fontSize: 10)),
                                  InkWell(
                                      // ignore: sdk_version_set_literal
                                      onTap: () => {
                                            Navigator.of(context)
                                                .pushNamed(LoginPage.id)
                                          },
                                      child: AutoSizeText(
                                        "Login",
                                        style: TextStyle(
                                            color: AppColor.c3, fontSize: 10),
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
                                      color: Colors.white,
                                      height: 50,
                                    )),
                              ),
                              Text("OR"),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.white,
                                      height: 50,
                                    )),
                              ),
                            ]),
                            Container(
                              height: SizeConfig.blockSizeVertical * 8,
                              width: SizeConfig.blockSizeHorizontal * 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 80, left: 80),
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
                                        radius: 32,
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  void registerUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: AppColor.c4,
            title:
                Text('Signing Up....', style: TextStyle(color: Colors.black)),
          );
        });
    //Center(child: CircularProgressIndicator());
    User user;
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((auth) {
        user = auth.user;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.pop(context);
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColor.c4,
                title: Text(
                  'User Already Exist(Try To Login)',
                  style: TextStyle(color: Colors.black),
                ),
              );
            });
      } else if (e.code == "ERROR_WEAK_PASSWORD") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColor.c4,
                title: Text(
                  'Weak Password',
                  style: TextStyle(color: Colors.black),
                ),
              );
            });
      } else if (e.code == "error") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColor.c4,
                title: Text(
                  'Fill Out All Details',
                  style: TextStyle(color: Colors.black),
                ),
              );
            });
      }
    }
    if (user != null) {
      saveUserToFirestore(user);
      await ServiceApp.sharedPreferences.setString(ServiceApp.typeLogin, "");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OnBoardingPage();
      }));
    }
  }

  Future saveUserToFirestore(User user) async {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "profilePicture":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      "phone": _phoneController.text.trim().toString(),
      "username": _firstNameController.text.trim() +
          " " +
          _lastNameController.text.trim()
    });
    await ServiceApp.sharedPreferences.setString("uid", user.uid);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userEmail, user.email);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userFirstName, _firstNameController.text);
    await ServiceApp.sharedPreferences.setString(ServiceApp.userAvatarUrl,
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png");
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userLastName, _lastNameController.text);
    await ServiceApp.sharedPreferences
        .setString(ServiceApp.userPhone, _phoneController.text.toString());
  }
}

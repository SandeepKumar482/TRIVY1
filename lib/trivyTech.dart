import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ServiceApp {
  static const String appName = 'e-Shop';
  static List<dynamic> selectedChoices = [];
  static List<dynamic> selectedChoicesTravler = [];
  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore;
  static String typeLogin="google";
  static String collectionUser = "users";
  static String collectionOrders = "orders";
  static String userCartList = 'userCart';
  static String subCollectionAddress = 'userAddress';
  static final String userFirstName = 'firstName';
  static final String userLastName = 'lastName';
  static final String userEmail = 'email';
  static final String userPhone = 'phone';
  static final String userUID = 'uid';
  static final String userAvatarUrl = 'profilePicture';
  static final String userName = 'username';
  static final String flightnumber = 'flightnumber';
  static final String from = 'from';
  static final String to = 'to';
  static final String weight = 'weight';
  static final String trips = 'trips';
  static final String dob = 'dob';
  static final String coverUrl='';
  static final String aadhaarUrl='AadhaarUrl';
  static final String dlUrl='DlUrl';
  static final String panUrl='PanUrl';
  static final String passportUrl='PassportUrl';
}

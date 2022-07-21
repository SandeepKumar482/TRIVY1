import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/trivyTech.dart';

import 'LoginPhone.dart';
import 'Welcome/welcome_screen.dart';

class MenuItems {
  static const home = MenuModel('Home', Icons.home);
  static const profile = MenuModel('My Profile', Icons.account_circle);
  static const myTrips = MenuModel('My Trips', Icons.flight);
  static const myWallet = MenuModel('My Wallet', Icons.account_balance_wallet);
  static const myMatch =
      MenuModel('My Matches', Icons.airline_seat_recline_extra_sharp);
  static const howToUse = MenuModel('How To Use', Icons.info);
  static const faqs = MenuModel('FAQs', Icons.help);
  static const about = MenuModel('About US', Icons.info);
  static const contact = MenuModel('Contact Us', Icons.question_answer);
  static const terms = MenuModel('Terms & Conditions', Icons.content_paste);
  static const order = MenuModel('Order', Icons.add_shopping_cart);

  static const all = <MenuModel>[
    home,
    profile,
    order,
    myTrips,
    myWallet,
    myMatch,
    howToUse,
    faqs,
    about,
    contact,
    terms
  ];
}

class Menu extends StatefulWidget {
  // const Menu({Key? key}) : super(key: key);
  final MenuModel currentPage;
  final ValueChanged<MenuModel> onSelectedPage;
  const Menu(this.currentPage, this.onSelectedPage);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> logout() async {
    try {
      if (ServiceApp.sharedPreferences.getString(ServiceApp.typeLogin) ==
          "google") {
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
    return Scaffold(
      backgroundColor: AppColor.c1,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.c4,
                        backgroundImage: NetworkImage(ServiceApp
                            .sharedPreferences
                            .getString(ServiceApp.userAvatarUrl)),
                        maxRadius: 50,
                      ),
                      Text(
                        ServiceApp.sharedPreferences
                                .getString(ServiceApp.userFirstName) +
                            " " +
                            ServiceApp.sharedPreferences
                                .getString(ServiceApp.userLastName),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...MenuItems.all.map(buildMenuItems).toList(),

            // ListTile(
            //   title: Text('Home'),
            //   leading: Icon(Icons.home),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, MyAccount.id);
            //   },
            // ),
            // Divider(
            //   color: AppColor.c4,
            // ),
            // ListTile(
            //   title: Text('My Profile'),
            //   leading: Icon(Icons.account_circle),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Profile.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('My Trips'),
            //   leading: Icon(Icons.flight),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, MyTrips.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('My Wallet'),
            //   leading: Icon(Icons.account_balance_wallet),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('My Matches'),
            //   leading: Icon(Icons.airline_seat_recline_extra_sharp),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, MyMatch.id);
            //   },
            // ),
            // Divider(
            //   color: AppColor.c4,
            // ),
            // ListTile(
            //   title: Text('How To Use'),
            //   leading: Icon(Icons.info),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, How.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('FAQs'),
            //   leading: Icon(Icons.help),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Help.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('About Us'),
            //   leading: Icon(Icons.info),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, About.id);
            //   },
            // ),
            // ListTile(
            //   title: Text('Contact Us'),
            //   leading: Icon(Icons.question_answer),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Contact.id);
            //   },
            // ),
            // Divider(
            //   color: AppColor.c4,
            // ),
            // ListTile(
            //   title: Text('Terms & Conditions'),
            //   leading: Icon(Icons.content_paste),
            //   onTap: () {
            //     Navigator.pushReplacementNamed(context, Terms.id);
            //   },
            // ),
            // Divider(
            //   color: AppColor.c4,
            // ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WelcomeScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(MenuModel model) => ListTileTheme(
        selectedColor: AppColor.c3,
        child: ListTile(
          selected: widget.currentPage == model,
          minLeadingWidth: 16,
          leading: Icon(model.icon),
          title: Text(model.title),
          onTap: () {
            widget.onSelectedPage(model);
          },
        ),
      );
}

class MenuModel {
  final String title;
  final IconData icon;

  const MenuModel(this.title, this.icon);
}

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trivy/About.dart';
import 'package:trivy/Contact.dart';
import 'package:trivy/Help&Support.dart';
import 'package:trivy/How.dart';
import 'package:trivy/MyAccount.dart';
import 'package:trivy/MyTrips.dart';
import 'package:trivy/MyWallet.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/TC.dart';
import 'package:trivy/drawer_menu.dart';
import 'package:trivy/my_matches.dart';
import 'package:trivy/orderHome.dart';

class ZoomDrawerr extends StatefulWidget {
  // const ZoomDrawer({Key? key}) : super(key: key);
  static const String id = 'ZoomDrawer';

  @override
  ZoomDrawerrState createState() => ZoomDrawerrState();
}

class ZoomDrawerrState extends State<ZoomDrawerr> {
  final controller = ZoomDrawerController();
  MenuModel currentPage = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      style: DrawerStyle.Style1,
      menuScreen: Builder(
        builder: (context) => Menu(currentPage, (item) {
          setState(() {
            currentPage = item;
            ZoomDrawer.of(context).close();
          });
        }),
      ),
      mainScreen: getPage(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      backgroundColor: Colors.white,
      slideWidth: MediaQuery.of(context).size.width * .66,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeIn,
    );
  }

  Widget getPage() {
    switch (currentPage) {
      case MenuItems.home:
        return MyAccount();
      case MenuItems.order:
        return OrderHome();
      case MenuItems.myMatch:
        return MyMatch();
      case MenuItems.myWallet:
        return MyWallet();
      case MenuItems.profile:
        return Profile();
      case MenuItems.howToUse:
        return How();
      case MenuItems.faqs:
        return Help();
      case MenuItems.about:
        return About();
      case MenuItems.contact:
        return Contact();
      case MenuItems.terms:
        return Terms();
      case MenuItems.myTrips:
        return MyTrips();
    }
  }
}

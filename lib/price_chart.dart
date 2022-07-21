import 'package:flutter/material.dart';
/*import 'package:trivy/TC.dart';
import 'package:trivy/loginpage.dart';
import 'package:trivy/Earn.dart';
import 'package:trivy/Share.dart';
import 'package:trivy/Wallet.dart';
import 'package:trivy/About.dart';*/
import 'package:trivy/Contact.dart';
/*import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';*/
import 'package:trivy/EarnerHow.dart';
//import 'package:trivy/MyAccount.dart';
//import 'package:trivy/SharerHowage:trivy/Settings.dart';
import 'package:trivy/appColor.dart';

import 'Drawer.dart';
import 'MyAccount.dart';
import 'SharerHow.dart';

class PriceChart extends StatefulWidget {
  static const String id = 'How';
  @override
  _PriceChart createState() => _PriceChart();
}

class _PriceChart extends State<PriceChart>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, MyAccount.id);
      } as Future<bool> Function(),
      child: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.c3,
              foregroundColor: AppColor.c2,
              elevation: 10.0,
              child: Icon(Icons.question_answer),
              onPressed: () {
                Navigator.pushNamed(context, Contact.id);
              },
            ),
            backgroundColor: AppColor.c1,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Color(0xffeeeeee),
              ),
              title: Center(child: Text('Price Chart')),
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.settings),
              //     onPressed: () {
              //       Navigator.pushNamed(context, Settings.id);
              //     },
              //   )
              // ],
              elevation: 0,
              backgroundColor: Color(0xff232931),
              brightness: Brightness.dark,
              textTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(
                  color: AppColor.c4,
                  fontSize: 20,
                ),
              ),
              bottom: TabBar(
                controller: _controller,
                tabs: [
                  Text(
                    'Sharer',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.c4,
                        fontSize: 16),
                  ),
                  Text(
                    'Earner',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.c4,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            drawer: Drawerr(),
            body: TabBarView(
              controller: _controller,
              children: [Sharer(), Earner()],
            )),
      ),
    );
  }
}

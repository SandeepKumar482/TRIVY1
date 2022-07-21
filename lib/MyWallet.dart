import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trivy/appColor.dart';

import 'ZoomDrawer.dart';

class MyWallet extends StatefulWidget {
  static const String id = 'mywallet';

  @override
  _State createState() => _State();
}

class _State extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacementNamed(context, ZoomDrawerr.id),
      child: GestureDetector(
        onPanStart: (var on) {
          on != null ? ZoomDrawer.of(context).toggle() : null;
        },
        child: Scaffold(
          backgroundColor: AppColor.c1,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColor.c4),
            centerTitle: true,
            title: Text('MyWallet'),
            backgroundColor: AppColor.c6,
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context).toggle(),
              child: Icon(Icons.menu),
            ),
          ),
          body: Center(
              child: Container(
            child: Text(
              'COMING SOON....',
              style: TextStyle(
                  color: AppColor.c2,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          )),
        ),
      ),
    );
  }
}

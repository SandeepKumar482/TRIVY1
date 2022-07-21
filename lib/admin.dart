import 'package:flutter/material.dart';
import 'package:trivy/Drawer.dart';
import 'package:trivy/appColor.dart';

//import 'Contact.dart';
import 'EarnerAdmin.dart';
//import 'EarnerHow.dart';
import 'Settings.dart';
import 'SharerAdmin.dart';
//import 'SharerHow.dart';



class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.c1,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xffeeeeee),
            ),
            title: Center(child: Text('Admin')),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, Settings.id);
                },
              )
            ],
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
                      fontWeight: FontWeight.bold, color: AppColor.c4, fontSize: 18),
                ),
                Text(
                  'Earner',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.c4, fontSize: 18),
                )
              ],
            ),
          ),
          drawer: Drawerr(),
          body: TabBarView(
            controller: _controller,
            children: [SharerAdmin(), EarnerAdmin()],
          )),
    );
  }
}

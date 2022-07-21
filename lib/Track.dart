import 'dart:async';


import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:timeline_tile/timeline_tile.dart';

import 'package:trivy/TC.dart';
import 'package:trivy/appColor.dart';
import 'package:trivy/loginpage.dart';

import 'package:trivy/Wallet.dart';
import 'package:trivy/About.dart';
import 'package:trivy/Contact.dart';
import 'package:trivy/MyTrips.dart';
import 'package:trivy/Help&Support.dart';
import 'package:trivy/How.dart';
import 'package:trivy/Profile.dart';
import 'package:trivy/Settings.dart';

class Track extends StatefulWidget {
  static const String id = 'Track';

  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  //final Set<Marker> _markers = {};


  MapType _currentMapType = MapType.normal;

  /*void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }*/

  // void _onAddMarkerButtonPressed() {
  //   setState(() {
  //     _markers.add(Marker(
  //       // This marker id can be anything that uniquely identifies each marker.
  //       markerId: MarkerId(_lastMapPosition.toString()),
  //       position: _lastMapPosition,
  //       // infoWindow: InfoWindow(
  //       //   title: 'Really cool place',
  //       //   snippet: '5 Star Rating',
  //       // ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }

  void _onCameraMove(CameraPosition position) {
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    return Scaffold(
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
        title: Center(child: Text('Tracker')),
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
      ),
      body: ListView(
        children: [
          Container(
            height: (mediaQuerry.size.height) / 3,
            width: (mediaQuerry.size.width),
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 16,
                  ),
                  mapType: _currentMapType,
                  //markers: _markers,
                  onCameraMove: _onCameraMove,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Align(
                //     alignment: Alignment.topRight,
                //     child: FloatingActionButton(
                //       //onPressed: _onAddMarkerButtonPressed,
                //       materialTapTargetSize: MaterialTapTargetSize.padded,
                //       backgroundColor: Colors.green,
                //       child: const Icon(Icons.map, size: 36.0),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            //height: (mediaQuerry.size.height) / 4,
            width: (mediaQuerry.size.width),
                      child: SingleChildScrollView(
              child: Column(
                children: [
                  TimelineTile(
                    topLineStyle: LineStyle(color:Color(0xff4ecca3) ),
                    
            alignment: TimelineAlign.left,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
                  width: 20,
                  indicatorY: 0.2,
                  color: Color(0xff4ecca3),
                  padding: EdgeInsets.all(8),
            ),
            rightChild: Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
                  child: Column(
                    children: [
                      //SvgPicture.asset(order_processed, height: 50, width: 50,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sharer",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColor.c4),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "we are preparing your order",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
            ),
          ),
          TimelineTile(
            topLineStyle: LineStyle(color:Color(0xff4ecca3) ),
            alignment: TimelineAlign.left,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
                  width: 20,
                  indicatorY: 0.2,
                  color: Color(0xff4ecca3),
                  padding: EdgeInsets.all(8),
            ),
            rightChild: Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
                  child: Column(
                    children: [
                      //SvgPicture.asset(order_processed, height: 50, width: 50,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sharer",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColor.c4),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "we are preparing your order",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
            ),
          ),
          TimelineTile(
            topLineStyle: LineStyle(color:Colors.grey),
            alignment: TimelineAlign.left,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
                  width: 20,
                  indicatorY: 0.2,
                  color: Color(0xff4ecca3),
                  padding: EdgeInsets.all(8),
            ),
            rightChild: Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
                  child: Column(
                    children: [
                      //SvgPicture.asset(order_processed, height: 50, width: 50,),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sharer",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColor.c4),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "we are preparing your order",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
            ),
          ),
          
                ],
              ),
            ),
          ),
          
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: AppColor.c1,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.c3,
                ),
                accountName: Text(
                  'Pulkit Agarwal',
                  style: TextStyle(
                    color: AppColor.c2,
                    fontSize: 16.0,
                  ),
                ),
                accountEmail: Text(
                  'pulkitagarwal2899@gmail.com',
                  style: TextStyle(
                    color: AppColor.c2,
                    fontSize: 16.0,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColor.c4,
                  child: Text('P'),
                ),
              ),
              ListTile(
                title: Text('My Profile'),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.pushNamed(context, Profile.id);
                },
              ),
              ListTile(
                title: Text('My Trips'),
                leading: Icon(Icons.flight),
                onTap: () {
                  Navigator.pushNamed(context, MyTrips.id);
                },
              ),
              ListTile(
                title: Text('My Wallet'),
                leading: Icon(Icons.account_balance_wallet),
                onTap: () {
                  Navigator.pushNamed(context, Wallet.id);
                },
              ),
              Divider(
                color: AppColor.c4,
              ),
              ListTile(
                title: Text('How We Work'),
                leading: Icon(Icons.info),
                onTap: () {
                  Navigator.pushNamed(context, How.id);
                },
              ),
              ListTile(
                title: Text('Help & Support'),
                leading: Icon(Icons.help),
                onTap: () {
                  Navigator.pushNamed(context, Help.id);
                },
              ),
              ListTile(
                title: Text('About Us'),
                leading: Icon(Icons.info),
                onTap: () {
                  Navigator.pushNamed(context, About.id);
                },
              ),
              ListTile(
                title: Text('Contact Us'),
                leading: Icon(Icons.question_answer),
                onTap: () {
                  Navigator.pushNamed(context, Contact.id);
                },
              ),
              Divider(
                color: AppColor.c4,
              ),
              ListTile(
                title: Text('Terms & Conditions'),
                leading: Icon(Icons.content_paste),
                onTap: () {
                  Navigator.pushNamed(context, Terms.id);
                },
              ),
              Divider(
                color: AppColor.c4,
              ),
              ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

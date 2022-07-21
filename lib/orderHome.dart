import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'ZoomDrawer.dart';
import 'appColor.dart';

class OrderHome extends StatelessWidget {
  // const OrderHome({Key? key}) : super(key: key);

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
            title: Text('Order'),
            backgroundColor: AppColor.c6,
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context).toggle(),
              child: Icon(Icons.menu),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Shop Products Globally And Get by Traveller',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Create Order',
                                  style: TextStyle(fontSize: 20))))
                    ]),
                    Row(
                      children: [
                        Card(
                          color: AppColor.c2,
                          elevation: 05,
                          child: Container(
                            child:
                                Text('Amazon', style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

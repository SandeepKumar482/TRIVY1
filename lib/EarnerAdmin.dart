import 'package:flutter/material.dart';
import 'package:trivy/appColor.dart';

class EarnerAdmin extends StatefulWidget {
  @override
  _EarnerAdminState createState() => _EarnerAdminState();
}



class _EarnerAdminState extends State<EarnerAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.c1,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  detailsContainer(
                      context, 32324, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                  detailsContainer(
                      context, 2, 'delhi', 'indore', 'none', 15, 'none'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container detailsContainer(
      BuildContext context, fno, from, to, status, extra, avail) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                ),
                Text(
                  ' Earner ',
                  style: TextStyle(
                      fontSize: 20, color: AppColor.c4, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.person,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Name : Pulkit',
                  style: TextStyle(fontSize: 20, color: AppColor.c4),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Flight no : $fno',
                  style: TextStyle(fontSize: 20, color: AppColor.c4),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'From : $from',
                      style: TextStyle(fontSize: 20, color: AppColor.c4),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'To : $to',
                      style: TextStyle(fontSize: 20, color: AppColor.c4),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Date of travel: 23/10/2020',
                      style: TextStyle(fontSize: 20, color: AppColor.c4),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Extra luggage/space: 6 Kg',
                      style: TextStyle(fontSize: 20, color: AppColor.c4),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, right: 20.0, left: 40.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Price Quote: 300',
                      style: TextStyle(fontSize: 20, color: AppColor.c4),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c3])),
    );
  }
}

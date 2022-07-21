import 'package:flutter/material.dart';

import 'ZoomDrawer.dart';

class Wallet extends StatelessWidget {
  static const String id = 'Wallet';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(
              'Coming Soon....',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:trivy/Drawer.dart';
// import 'package:trivy/TC.dart';
// import 'package:trivy/loginpage.dart';
// import 'package:trivy/Earn.dart';
// import 'package:trivy/Share.dart';
// import 'package:trivy/MyAccount.dart';
// import 'package:trivy/Contact.dart';
// import 'package:trivy/About.dart';
// import 'package:trivy/MyTrips.dart';
// import 'package:trivy/Help&Support.dart';
// import 'package:trivy/How.dart';
// import 'package:trivy/Profile.dart';
// import 'package:trivy/Settings.dart';
//
// class Wallet extends StatefulWidget {
//   static const String id = 'Wallet';
//   @override
//   _WalletState createState() => _WalletState();
// }
//
// class _WalletState extends State<Wallet> {

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff23231),
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Color(0xffeeeeee),
//           ),
//           title: Center(child: Text('Wallet')),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 Navigator.pushNamed(context, Settings.id);
//               },
//             )
//           ],
//           elevation: 0,
//           backgroundColor: Color(0xff232931),
//           brightness: Brightness.dark,
//           textTheme: TextTheme(
//               title: TextStyle(
//                 color: Color(0xffeeeeee),
//                 fontSize: 20,
//               )),
//         ),
//         drawer: Drawerr(),
//         body: Container(
//           color: AppColor.c4,
//           child: Column(
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                     color: Color(0xff232931),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20))),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 50, bottom: 25, left: 50, right: 50),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Current Balance',
//                               style: TextStyle(fontSize: 20, color: AppColor.c4),
//                             ),
//                             Text(
//                               '₹2601.20',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: AppColor.c4,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 25, bottom: 50, left: 50, right: 50),
//                             child: Text(
//                               'Add Money',
//                               style: TextStyle(fontSize: 20, color: AppColor.c4),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 25, bottom: 50, left: 50, right: 50),
//                             child: RaisedButton(
//                               child: Text(
//                                 '+',
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   color: AppColor.c4,
//                                 ),
//                               ),
//                               color: Color(0xff232931),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(80)),
//                               onPressed: () {
//                                 print('saket');
//                               },
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient: LinearGradient(
//                           colors: [Color(0xff232931), Color(0xff4ecca3)])),
//                 ),
//               ),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Your Transactions',
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: AppColor.c2,
//                     ),
//                   )
//                 ],
//               ),
//
//               //ListView(
//               // children: const <Widget>[
//               //Card(child: ListTile(title: Text('One-line ListTile'))),]
//
//               //    )
//               Expanded(
//                 child: SizedBox(
//                   child: ListView(
//                     children: <Widget>[
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_downward,
//                             color: Colors.red,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_downward,
//                             color: Colors.red,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_downward,
//                             color: Colors.red,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.red,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_upward,
//                             color: Colors.green,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                       Card(
//                         child: ListTile(
//                           title: Text(
//                             'One-line ListTile',
//                             style:
//                             TextStyle(fontSize: 20, color: AppColor.c4),
//                           ),
//                           leading: Icon(
//                             Icons.arrow_downward,
//                             color: Colors.red,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.more_horiz),
//                             onPressed: () {},
//                           ),
//                         ),
//                         color: AppColor.c2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

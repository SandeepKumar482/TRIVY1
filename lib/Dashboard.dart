import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:trivy/Drawer.dart';
import 'package:trivy/appColor.dart';

class Dashboard extends StatefulWidget {
  static const String id = "dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}
List<Map> dashboardOptions=[
  { 
    "icon" :Icons.local_airport,
    "name": "Share Luggage at Airports ",
  },
   {
     "icon" :Icons.local_shipping,
     "name": "Share anything to anyone \nin your city",
   } ,
   {
     "icon" :Icons.local_taxi,
     "name": "Book Local Taxi",
   },
   {
     "icon" :Icons.motorcycle,
     "name": "Book Local Bike",
   },
   {
     "icon" :Icons.electric_rickshaw,
     "name": "Book Local Auto",
   },
   {
     "icon" :Icons.celebration,
     "name": "Book Local Gigs"
   }];

class _DashboardState extends State<Dashboard> {
   List <Widget> navBar=[
   
  ];
  int _selectIndex = 0;
void onTabTapped(int index) {
   setState(() {
     _selectIndex = index;
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c1,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xffeeeeee),
            ),
           
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.message_outlined)
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
            
          ),
          bottomNavigationBar: BottomNavigationBar(            
            onTap: onTabTapped,
            currentIndex: _selectIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home")
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_shipping),
                title: Text("Share")
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_taxi),
                title: Text("Book Local Taxi")
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                title: Text("Trivy Wallet")
                ),
            ],
            type: BottomNavigationBarType.shifting,           
            selectedItemColor: AppColor.c3,           
            
            ),
          drawer: Drawerr(),
          body:
                     Column(
                          children: [
                          Container(
                          margin: EdgeInsets.all(10),
                          height: 125,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                                border: Border.all(color: AppColor.c3),
                                borderRadius: BorderRadius.circular(20),                      
                              ),
                          child: Center(
                            child: Text("containt")
                            ) ,
          
                        ),
                        //
                        myTrivy(),
                        
                            ],
                        ),
                    
                    
                
              );
            }
          }
          

Widget myTrivy(){
  return Container(
    margin: EdgeInsets.all(10),
    height: 400,
    decoration: BoxDecoration(
      color: AppColor.c1,
      border: Border.all(),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      )

    ),
    child: Column(
      children: [
        Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("My Trivy"),
                  ),
                ],
              ),
                  Expanded(
                    child:  GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio:3/2, 
                          // crossAxisSpacing: 5,
                          // mainAxisSpacing: 5,
                          ), 
                        itemCount: dashboardOptions.length,
                        itemBuilder: (BuildContext context, index){
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.c4),
                              borderRadius: BorderRadius.circular(20),
                              
                            ),
                            height: 150,
                            alignment: Alignment.center,
                            child:  Column(
                              
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Icon(dashboardOptions[index]['icon'],color:AppColor.c4,size: 50,)),
                                  
                                ),
                                Text(dashboardOptions[index]['name'],style: TextStyle(fontSize: 10),),
                              ],
                            ),

                          );
                        }
                      
                 
                    ),
                  )
      ],
    ),
  );
}
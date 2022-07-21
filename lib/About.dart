import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  static const String id = 'About';
  @override
  _AboutState createState() => _AboutState();
}

String url = "";

_launchURL(String url) async {
  print(url);
  await launch(url);
}

class _AboutState extends State<About> {
  // ignore: unused_field
  int _currentIndex = 0;
  List cardList = [
    Item1(),
    Item2(),
    Item3(),
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
      },
      child: SafeArea(
        child: Center(
          child: Scaffold(
            backgroundColor: AppColor.c1,
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: AppColor.c3,
            //   foregroundColor: AppColor.c2,
            //   elevation: 10.0,
            //   child: Icon(Icons.question_answer),
            //   onPressed: () {
            //     Navigator.pushNamed(context, Contact.id);
            //   },
            // ),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppColor.c1,
              ),
              leading: InkWell(
                onTap: () => ZoomDrawer.of(context).toggle(),
                child: Icon(Icons.menu),
              ),
              title: Center(child: Text('About Us')),
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.settings),
              //     onPressed: () {
              //       Navigator.pushNamed(context, Settings.id);
              //     },
              //   )
              // ],
              elevation: 0,
              backgroundColor: AppColor.c6,
              brightness: Brightness.light,
              textTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(
                  color: AppColor.c2,
                  fontSize: 20,
                ),
              ),
            ),
            // drawer: Drawerr(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Changing the Way People Travel ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.c2,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Next generation luggage pooling service',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.c2,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ABOUT THE PLATFORM ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.c2,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            '''Trivy is a peer-to-peer SaaS based platform that allows two travelers to share luggage It serves as a connecting platform for two people, one with overweight luggage and the other with very little or no luggage. Further, it enables worldwide customers to purchase things from the global store at significantly lower prices than those in their own region, allowing them to have their Christmas desires fulfilled by a santa who is traveling to and from their city from another country. The website provides a secure environment for easy luggage sharing, with monetary benefits for the users in all ways.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 1.0,
                              wordSpacing: 2.0,
                              color: AppColor.c2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient:
                            LinearGradient(colors: [AppColor.c1, AppColor.c6])),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ABOUT Culture :',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.c2,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            ''' Trivy is dedicated to reimagining travel for millions of people, believing that it is an experience that is best shared with others. We don't believe in measuring distances, but rather in providing excellent service and precision..''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 1.0,
                              wordSpacing: 2.0,
                              color: AppColor.c2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient:
                            LinearGradient(colors: [AppColor.c1, AppColor.c6])),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ABOUT COMPANY :',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.c2,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            ''' Trivy was formed by our founder when he traveled for the first time on a flight and encountered a traveler enduring luggage complications; it was then that the actual core of trivy was endowed. The Team at Trivy believes in teamwork and putting in countless hours. While providing the best of the stress-free travel luggage service, our basic principles are safety and convenience.

Our vision is to provide best in the traveling and luggage handling community to cope with the high rates of extra passenger baggage and the stress that comes with traveling heavy. 

Additional - - - We strive to deliver the greatest travel experience and the happiest shopping environment to the worldwide traveling community, as well as the luggage handling community, to help them deal with the high rates of excess baggage and the stress that comes with traveling heavy. 
We want to be the de facto travel experience for everyone.
.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 1.0,
                              wordSpacing: 2.0,
                              color: AppColor.c2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient:
                            LinearGradient(colors: [AppColor.c1, AppColor.c6])),
                  ),
                  // Text(
                  //   'How We Work?',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: AppColor.c4,
                  //     fontSize: 30.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // CarouselSlider(
                  //   height: 420.0,
                  //   autoPlay: true,
                  //   autoPlayInterval: Duration(seconds: 3),
                  //   autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  //   pauseAutoPlayOnTouch: Duration(seconds: 10),
                  //   aspectRatio: 2.0,
                  //   onPageChanged: (index) {
                  //     setState(() {
                  //       _currentIndex = index;
                  //     });
                  //   },
                  //   items: cardList.map((card) {
                  //     return Builder(builder: (BuildContext context) {
                  //       return Container(
                  //         height: MediaQuery.of(context).size.height * 0.30,
                  //         width: MediaQuery.of(context).size.width,
                  //         child: Card(
                  //           color: AppColor.c1,
                  //           elevation: 0.0,
                  //           child: card,
                  //         ),
                  //       );
                  //     });
                  //   }).toList(),
                  // ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '''“Great things in business are never done by one person. They’re done by a team of people.”''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              wordSpacing: 1.0,
                              color: AppColor.c2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            '''Our company believes in working together and working hard. We don’t measure distance,
We believe in services and accuracy.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              wordSpacing: 2.0,
                              letterSpacing: 1.0,
                              color: AppColor.c2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient:
                            LinearGradient(colors: [AppColor.c1, AppColor.c6])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 18.0, left: 65.0, right: 65.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: AppColor.c2,
                          thickness: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "MEET THE TEAM",
                          style: TextStyle(
                            color: AppColor.c2,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColor.c2,
                          thickness: 5.0,
                        ),
                      ),
                    ]),
                  ),
                  ExpandableTeamTile(
                      "Shivansh Aggarwal",
                      "Founder",
                      "images/F1.png",
                      "https://www.linkedin.com/company/trivy-technologies-pvt-ltd"),
                  ExpandableTeamTile(
                      "Kunj Joshi",
                      "Operations & HR",
                      "images/HR.jpeg",
                      "https://www.linkedin.com/company/trivy-technologies-pvt-ltd"),
                  ExpandableTeamTile(
                      "Sandeep Kumar",
                      "Flutter Developer",
                      "images/FlutterDeveloper.jpeg",
                      "https://www.linkedin.com/in/sandeep-kumar-5b95431a7/"),
                  ExpandableTeamTile(
                      "Pratiksha Chawla",
                      "Social Media and Branding",
                      "images/SocialMediaAndBranding.jpeg",
                      " "),
                  ExpandableTeamTile("Akash Babu", "Graphics And Animations",
                      "images/GraphicalDesigner.jpeg", " "),
                  ExpandableTeamTile("Saheba Kapoor", "Content Writer",
                      "images/ContentWriter.jpg", " "),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandableTeamTile extends StatelessWidget {
  String image, name, designation, url;
  ExpandableTeamTile(this.name, this.designation, this.image, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, right: 20.0, left: 20.0),
        child: Column(
          children: <Widget>[
            ExpansionTile(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(image),
                    radius: 100.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: AppColor.c2,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    designation,
                    style: TextStyle(
                      color: AppColor.c2,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SignInButton(
                      Buttons.LinkedIn,
                      mini: true,
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      mini: true,
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Card(
                      child: SocialMediaButton.instagram(
                        url: 'null',
                        size: 23.0,
                        onTap: () {},
                      ),
                      color: Colors.black12,
                    ),
                  ],
                ),
              ],
              title: Text(
                name,
                style: TextStyle(
                  color: AppColor.c2,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                designation,
                style: TextStyle(
                  color: AppColor.c2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 25.0,
              ),
              trailing: SignInButton(
                Buttons.LinkedIn,
                mini: true,
                onPressed: () {
                  url = url;
                  _launchURL(url);
                },
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c6])),
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Image.asset('images/slider-1.png'),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '''Book and share luggage space with others.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: AppColor.c2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c6])),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Image.asset('images/Slider2-1.png'),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '''Exchange Luggage and Travel stress-free with others.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: AppColor.c2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c6])),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Image.asset('images/Slider3-1.png'),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '''Earn by sharing your luggage space with others.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: AppColor.c2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [AppColor.c1, AppColor.c6])),
    );
  }
}

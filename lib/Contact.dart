import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trivy/ZoomDrawer.dart';
import 'package:trivy/appColor.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  static const String id = 'Contact';
  // static String url ="";
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  String url = "";
  static String message = "";
  _launchURL(String url) async {
    print(url);
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, ZoomDrawerr.id);
        },
        child: SafeArea(
          child: GestureDetector(
            child: GestureDetector(
              onPanStart: (var on) {
                on != null ? ZoomDrawer.of(context).toggle() : null;
              },
              child: Scaffold(
                backgroundColor: AppColor.c1,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: AppColor.c1,
                  ),
                  leading: InkWell(
                    onTap: () => ZoomDrawer.of(context).toggle(),
                    child: Icon(Icons.menu),
                  ),
                  title: Center(child: Text('Contact Us')),
                  actions: <Widget>[],
                  elevation: 0,
                  backgroundColor: AppColor.c6,
                  brightness: Brightness.light,
                  textTheme: TextTheme(
                      // ignore: deprecated_member_use
                      title: TextStyle(
                    color: AppColor.c2,
                    fontSize: 20,
                  )),
                ),
                // drawer: Drawerr(),
                floatingActionButton: SpeedDial(
                  backgroundColor: AppColor.c3,
                  foregroundColor: AppColor.c2,
                  animatedIcon: AnimatedIcons.add_event,
                  overlayOpacity: 0,
                  children: [
                    SpeedDialChild(
                      child: Icon(FontAwesomeIcons.facebook),
                      backgroundColor: AppColor.c3,
                      foregroundColor: AppColor.c2,
                      onTap: () {
                        url =
                            "https://www.facebook.com/TRIVY-101606317994756/?ref=page_internal";
                        _launchURL(url);
                      },
                    ),
                    SpeedDialChild(
                      child: Icon(FontAwesomeIcons.instagram),
                      backgroundColor: AppColor.c3,
                      foregroundColor: AppColor.c2,
                      onTap: () {
                        url = "https://www.instagram.com/trivy_tech/";
                        _launchURL(url);
                      },
                    ),
                    SpeedDialChild(
                      child: Icon(FontAwesomeIcons.linkedin),
                      backgroundColor: AppColor.c3,
                      foregroundColor: AppColor.c2,
                      onTap: () {
                        url =
                            "https://www.linkedin.com/company/trivy-technologies-pvt-ltd";
                        _launchURL(url);
                      },
                    ),
                  ],
                ),
                body: Container(
                  color: AppColor.c2,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.c1,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: FormBuilder(
                            autovalidateMode: AutovalidateMode.always,
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormBuilderTextField(
                                      attribute: 'Full Name',
                                      decoration: InputDecoration(
                                        labelText: "Full Name",
                                      ),
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    validators: [
                                      FormBuilderValidators.numeric()
                                    ],
                                    attribute: 'Mobile Number',
                                    decoration: InputDecoration(
                                      labelText: "Mobile Number",
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormBuilderTextField(
                                    validators: [FormBuilderValidators.email()],
                                    attribute: 'E-mail',
                                    decoration: InputDecoration(
                                      labelText: "E-Mail",
                                    ),
                                    maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: FormBuilderTextField(
                                //     attribute: 'Address',
                                //     decoration: InputDecoration(
                                //       labelText: "Address",
                                //     ),
                                //     maxLines: 5,
                                //     keyboardType: TextInputType.text,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FormBuilder(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: AppColor.c2,
                            ),
                            child: FormBuilderTextField(
                              enableInteractiveSelection: true,
                              attribute: 'Message',
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.c1, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.c1, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.c1, width: 1.0),
                                ),
                                labelStyle: TextStyle(
                                  color: AppColor.c2,
                                ),
                                focusColor: AppColor.c2,
                                labelText: "Your Message Here",
                              ),
                              onChanged: (value) {
                                message = value;
                              },
                              maxLines: 10,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColor.c2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: RaisedButton.icon(
                            color: AppColor.c3,
                            elevation: 10.0,
                            textColor: AppColor.c2,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(50.0),
                                    right: Radius.circular(50.0))),
                            icon: Icon(Icons.spellcheck),
                            label: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            onPressed: () async {
                              final Email email = Email(
                                body: message,
                                subject: 'Trivy Contact form',
                                recipients: ['Contact@trivytech.in'],
                                isHTML: false,
                              );
                              try {
                                await FlutterEmailSender.send(email);
                                showSnackbar();
                              } catch (e) {
                                print("Error in sending mail--------$e");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // Future sendEmail(String msg) async {
  //   final email = ServiceApp.auth.currentUser.email;
  //   var userName = ServiceApp.auth.currentUser.displayName;
  //   String token1;
  //
  //   final message = Message()
  //     ..from = Address(email, userName)
  //     ..recipients.add('Contact@trivytech.in')
  //     ..text = msg
  //     ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
  //
  //   try {
  //     await showSnackbar();
  //     Navigator.pop(context);
  //     FirebaseAuth.instance.idTokenChanges().listen((token) {
  //       if (token == null) {
  //         print('User is currently signed out!');
  //       } else {
  //         print('User is signed in!');
  //         token1 = token as String;
  //       }
  //     });
  //     final smtpServer = gmailSaslXoauth2(email, token1);
  //     final sendReport = await send(message, smtpServer);
  //     showSnackbar();
  //     Navigator.pop(context);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent. $e');
  //     for (var p in e.problems) {
  //       print('Problem: ${p.code}: ${p.msg}');
  //     }
  //   }
  // }

  void showSnackbar() {
    final snackbar = SnackBar(
      content: Text(
        'Thanks for Contacting us. We will contact you soon..',
        style: TextStyle(fontSize: 18, color: AppColor.c1),
      ),
      backgroundColor: AppColor.c3,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}

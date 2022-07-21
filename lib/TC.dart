import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trivy/appColor.dart';

import 'ZoomDrawer.dart';

class Terms extends StatefulWidget {
  static const String id = 'terms';
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
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
                    color: Color(0xffeeeeee),
                  ),
                  leading: InkWell(
                    onTap: () => ZoomDrawer.of(context).toggle(),
                    child: Icon(Icons.menu),
                  ),
                  backgroundColor: AppColor.c6,
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text('Terms and Conditions'),
                  // actions: <Widget>[
                  //   IconButton(
                  //     icon: Icon(Icons.settings),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, Settings.id);
                  //     },
                  //   )
                  // ],
                  brightness: Brightness.dark,
                  textTheme: TextTheme(
                      // ignore: deprecated_member_use
                      title: TextStyle(
                    color: Color(0xffeeeeee),
                    fontSize: 20,
                  )),
                ),
                // drawer: Drawerr(),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    color: AppColor.c1,
                    child: ListView(
                      children: <Widget>[
                        Text(
                          'Trademark and Copyright',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          "The services contain copyrighted material, trademarks and other proprietaries. The company name, the logo, the products are associated with the company's trademark.",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Security and Privacy',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          "Trivy takes the security and privacy very seriously. We review our websites frequently so that the data remains private. The data which the customers provide us will be used only for verification and stored in our server. It will not be revelatory shared to anyone. Trivy will take legal action against the leakage of any kind of data. By using this website, you agree to the terms laid down in the website privacy policy and the customer terms and conditions for different services in it.",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Interaction with others',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          "1. You are responsible for your interaction with the other members. Our services provide you a platform for interaction with the other members through chatting option that we have. Trivy is not responsible for the interaction or disputes with any members or your relations with any members. We hold the right but we have no obligations to interrupt between your interaction with other members. We request you to do a good judgement of people from the ratings that we provide.\n\n"
                          "2. We encourage you to take precautions while meeting a stranger for the first time and interaction with him/her.\n\n"
                          "3. In case of any personal dispute between the other members release us (our officers, directors, members, employees) . If you need any help from our side Trivy is ready for it but you are requested to take your responsibility for your own.",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Delivery Policy',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''The delivery time of your baggage will be based on your flight timings and also Trivy provides you a tracking system to keep the track of your luggage.
The policy also includes the insurance of your luggage.
                      ''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'The Customer',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''The first step towards using TRIVY is to create a User Account. You must be a natural person and of age 18+ to create your User account. Registration on the platform by a minor is strictly prohibited. In accessing, using or registering on the Platform, you represent and warrant that you are aged 18 or over. By registering a User profile in TRIVY you, as the User, enter into a legally binding agreement with TRIVY. If you do not wish to be bound to TRIVY, please do not register as a User. All registered Users can act both as Sender and Receiver.
By creating your User Account you:
1) agree to provide TRIVY the following personal information requested:
First name
Last name
Age (+18)
Contact number
Email address
2) To provide only information that are true, correct, non-misleading and complete.
Please note that Personal data will be disclosed only to the necessary extent to facilitate contact between the sender and the receiver
As Sender and Receiver you have to share your location details.
TRIVY uses the information provided by the User to make the Sender-Receiver matching possible so that a request can be handled by the Receiver.
All personal information is stored securely and processed in accordance with applicable legislation.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'The Company',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''TRIVY is a matching service. Our goal is to provide a platform where whoever wishes to have an item delivered wherever can find his/her match and have his/her item brought to its destination. Once the matching is complete, transportation arrangements are agreed by and between the Users only, as TRIVY is not a contractual party to any Users’ agreement.
TRIVY is not a commercial service and does not provide transportation services.
It is not a delivery transport solution: it is up to the Pony to provide the pick-up, carry and delivery services, which shall be scheduled in accordance with the Sender and Receiver. TRIVY has no responsibility for such matters and does not have the authority to enter into the transaction between the Sender and the Receiver. TRIVY provides the tracking system to track your receiver.

The service will be not performed in any professional context. The service takes place occasionally and the compensation agreed between Sender and Receiver is a kind contribution towards TRIVY expenses. The service does not give to Users the cancellation right because of the nature of the service itself.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Payment and Refund',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''The Price consists of two elements:
A) the Compensation for the Service which is solely subject to agreement between the Sender and Receiver.
B) the price for TRIVY Service (the “Service Fee”). The Service Fee shall be 10% of the Compensation for the Service as agreed between the Users.

TRIVY may add from time to time a price of other premium services. The Compensation for the Service offered by the Sender is agreed by the Receiver and shall be as set out in the agreement between the Users. 
CODE STEPS (DOUBT)

There won’t be any refund policy.
In case the luggage is misplaced then its recovery will be included in your insurance.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Member Representation and Warranties',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''TRIVY services are not available to persons under the age of 18. By using the software or services, you represent and warrant that you are at least 18 years old. By using TRIVY services, you represent and warrant that you have the right, authority and capacity to enter into this agreement and to abide by the terms and conditions of this agreement. Your participation in using the services is for your sole, personal use. You may not authorize others to use your user status, and you may not assign or otherwise transfer your user account to any other person or entity. You may only access the services using authorized means. 
The Site, application and Services comprise of a mobile and web platform through which the sender and receiver can contact each other and track their location.
TRIVY is not a transportation agency.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Limits on Liability:',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''UNDER NO CIRCUMSTANCES WILL ANY OF THE TRIVY PARTIES BE LIABLE FOR ANY LOSS OR DAMAGE CAUSED BY YOUR RELIANCE ON INFORMATION OBTAINED THROUGH THIS SITE/APP. IT IS YOUR RESPONSIBILITY TO EVALUATE THE ACCURACY, COMPLETENESS, OR USEFULNESS OF THIS SITE/APP. IN NO EVENT SHALL ANY OF THE TRIVY PARTIES BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF OR RELATING TO THE SITE OR THIS AGREEMENT, WHETHER BASED ON WARRANTY, CONTRACT, TORT, OR ANY OTHER LEGAL THEORY. BECAUSE SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR NEGLIGENCE, CONSEQUENTIAL, INCIDENTAL OR OTHER DAMAGES, IN SUCH JURISDICTIONS THE TRIVY PARTIES’ LIABILITY IS LIMITED TO THE GREATEST EXTENT PERMITTED BY LAW. YOUR SOLE REMEDY FOR DISSATISFACTION WITH THIS SITE/APP IS TO STOP USING THIS SITE/APP.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Intellectual Property Rights:',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''You acknowledge that this Site and various elements contained therein are protected by copyrights, trademarks, trade secrets, patents, or other proprietary rights, and that these worldwide rights are valid and protected in all forms, media, and technologies existing now and hereinafter developed. You also acknowledge that the Content is and shall remain our property or the property of our licensors. You agree to comply with all intellectual property laws and you shall not encumber any interest in, or assert any rights to, the Content. You may not modify, transmit, participate in the sale or transfer of, or create derivative works based on any Content, in whole or in part. These User Terms do not constitute a sale and do not convey to You any rights of ownership in or related to the Site, the Application or the Service, or any intellectual property rights owned by Ola. You shall be solely responsible for any violations of any laws and for any infringements of any intellectual property rights caused by use of the Services or the Site/ Application.

Use of personal data:

A. We use personally identifiable information you supply through the Site or Service to provide you with the merchandise, product, service, and/or Content you have requested.We may also use the information to communicate with you about new features, products or services, and/or to improve the services that we offer by tailoring them to your needs.\n
B. We will not sell, distribute or lease your personal information to third parties unless we have your permission, it is required to process your order or is required by law to do so. We may use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen.\n
C. We request information from you in order to process your order effectively, we are unable to place any orders without the information we outlined above including put not limited to your name, address, phone number and email address. We are unable to accept orders without this information. In addition, we reserve the right to use the information we collect about your computer, mobile or other device (including its geographic location), which may at times be able to identify you, for any lawful business purpose, including without limitation to help diagnose problems with our servers, to gather broad demographic information, analyse trends, track users’ movements around the Service, and to otherwise administer the Service. Geographic location information about you and/or your computer, mobile or other device may specifically be used to show you content and sponsored messaging based on geographic location.\n
D. We may anonymise your data and aggregate it with data from other users to understand how people are using our website and to evaluate our services. We reserve the right to disclose anonymised aggregated user data to approved third parties.\n
E. We reserve the right to use, transfer, sell, and share aggregated, anonymous data about our users as a group for any lawful business purpose, such as analysing usage trends and seeking compatible advertisers, sponsors, clients and customers.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'Injunctive Relief:',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''You and TRIVY agree to arbitrate any dispute arising from these Terms or relating to the Services, except that you and TRIVY are not required to arbitrate any dispute in which either party seeks equitable or other relief for the alleged unlawful use of copyrights, trademarks, trade names, logos, trade secrets or patents. ARBITRATION PREVENTS YOU FROM SUING IN COURT OR FROM HAVING A JURY TRIAL. You and TRIVY agree that you will notify each other of any dispute within thirty (30) days of when it arises, that you will attempt informal resolution prior to any demand for arbitration, that any arbitration will occur in Mumbai, Maharashtra, India. You and TRIVY also agree that the state or federal courts in Mumbai, Maharashtra, India have exclusive jurisdiction over any appeals of an arbitration award and over any suit between the parties not subject to arbitration.''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                        Text(
                          'User Messages:',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColor.c2,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                        ),
                        Text(
                          '''Your messages are yours, and we can’t read them. We’ve built privacy, end-to-end encryption, and other security features into TRIVY. We don’t store your messages once they’ve been delivered. When they are end-to-end encrypted, we and third parties can’t read them. ''',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColor.c2,
                          ),
                        ),
                        Divider(
                          color: AppColor.c2,
                          thickness: 1.0,
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trivy/MyAccount.dart';
import 'package:trivy/Welcome/welcome_screen.dart';
import 'package:trivy/appColor.dart';

import './button_widget.dart';

// ignore: must_be_immutable
class OnBoardingPage extends StatelessWidget {
  static const routName = '/introScreen';
  @override
  Widget build(BuildContext context) => Scaffold(
        /* appBar: AppBar(
            title: Text(
          "Trivy Technologies Pvt. Ltd.",
          style: TextStyle(
            color: AppColor.c4,
            fontSize: 20.0,
          ),
        )),*/
        body: SafeArea(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Welcome To Trivy',
                body:
                    'Share your extra baggae with anyone who is travelling with you, regardless of age.',
                image: buildImage('images/Intro1.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: "Stay Connected",
                body:
                    'Keep in touch with others and make better plans for your journey.',
                image: buildImage('images/Intro4.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Share and Earn',
                body: 'Share and Earn Money While Travelling',
                image: buildImage('images/Intro5.png'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: "Let's get Started!",
                body: 'Start Your Journey With Us',
                footer: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ButtonWidget(
                    text: 'Register Yourself',
                    onClicked: () => goToHome(context),
                  ),
                ),
                image: buildImage('images/Intro6.png'),
                decoration: getPageDecoration(),
              ),
            ],
            done:
                Text('Continue', style: TextStyle(fontWeight: FontWeight.w600)),
            onDone: () => goToHome(context),
            showSkipButton: true,
            skip: Text('Skip'),
            onSkip: () => goToHome(context),
            next: Icon(Icons.arrow_forward),
            dotsDecorator: getDotDecoration(),
            onChange: (index) => print('Page $index selected'),
            globalBackgroundColor: AppColor.c3,
            skipFlex: 0,
            nextFlex: 0,
            // isProgressTap: false,
            // isProgress: false,
            // showNextButton: false,
            // freeze: true,
            // animationDuration: 1000,
          ),
        ),
      );

  void goToHome(context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MyAccount()));
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: AppColor.c3,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.c4),
        bodyTextStyle: TextStyle(fontSize: 20, color: AppColor.c4),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: AppColor.c1,
      );
}

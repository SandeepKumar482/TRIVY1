import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trivy/LoginPhone.dart';
import 'package:trivy/SignUpNew.dart';
import 'package:trivy/Welcome/components/background.dart';
import 'package:trivy/components/constants.dart';
import 'package:trivy/components/rounded_button.dart';
import 'package:trivy/loginpage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO TRIVY",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "images/Welcome.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN WITH EMAIL",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            RoundedButton(
              text: "LOGIN WITH PHONE",
              press: () {
                Navigator.pushNamed(context, LoginPagePhone.id);
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Color(0xff4ecca3),
              press: () {
                Navigator.pushNamed(context, SignUp.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

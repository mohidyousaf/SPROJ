import 'package:flutter/material.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/Authentication/signup.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/colors.dart';

// This is the landing page of our Application where we have the option to login, signup or skip to explore the app.

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/LandingPage.png'),
            ))),
        Container(
          child: Positioned(
            top: 20,
            right: 20,
            child: Container(
                width: 80,
                child: buildButton2('Login', Color.fromRGBO(85, 68, 119, 1),
                    this.context, Login())),
          ),
        ),
        Positioned(
            bottom: 80,
            child: buildButton2('Join', Color.fromRGBO(255, 138, 128, 1),
                this.context, SignUp())),
        Positioned(
          bottom: 20,
          child: buildButton2('Skip', Color.fromRGBO(85, 68, 119, 1),
              this.context, HomeScreen()),
        )
      ]),
    );
  }
}

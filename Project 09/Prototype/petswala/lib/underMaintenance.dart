import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:petswala/profile.dart';

import 'homescreen_Casual.dart';

// void main() => runApp(MyApp());

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 1500,
            splashIconSize: 500,
            splash: new Image.asset('assets/maintenance.jpg'),
            nextScreen: HomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.white
        )
    );
  }
}

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.redAccent,
//     );
//   }
// }
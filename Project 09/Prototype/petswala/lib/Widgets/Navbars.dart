import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar(context);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset('assets/home.png',
                       height: 30,
                        width: 30,),
                  // Text('Home', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Image.asset('assets/marketplace.png',
                    height: 25,
                    width: 25,),
                ),
                  // Text('Shop', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/market');
              }
          ),
          TextButton(
              child:Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white12
                ),
                child: Image.asset('assets/emergency-call.png',
                height: 35,
                width: 35,),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/rescue');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Icon(Icons.chat_outlined,
                        color: Color.fromRGBO(84, 84, 84, .6),
                        size: 28,),
                  // Text('Edit', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                ],
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/reportsHome');
              }
          ),
          TextButton(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                    Icons.person_outline_outlined,
                    color: Color.fromRGBO(84, 84, 84, .6),
                    size: 32
                  ),
                // Text('Profile', style:
                // GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0))),
                // ),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ]
    );
  }
}

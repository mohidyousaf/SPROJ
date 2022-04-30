import 'package:flutter/cupertino.dart';
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
                // Icon(CupertinoIcons.home, 
                //     color: Color.fromRGBO(84, 84, 84, .6),
                //     size: 28,),
                Image.asset('assets/icons/home.png',
                       height: 30,
                        width: 30,),
                  // Text('Home', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                ],
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/home');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.bag, 
                      color: Color.fromRGBO(84, 84, 84, .6),
                      size: 28,),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 4),
                //   child: Image.asset('assets/marketplace.png',
                //     height: 25,
                //     width: 25,),
                // ),
                  // Text('Shop', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                ],
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/market');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset('assets/icons/icons8-activity-feed-32.png',
                height: 28,
                width: 28,),
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
                // Image.asset('assets/icons/icons8-male-user-16.png',
                // height: 30,
                //         width: 30,
                // ),
                Icon(
                    Icons.account_circle_outlined,
                    color: Color.fromRGBO(84, 84, 84, .6),
                    size: 28
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

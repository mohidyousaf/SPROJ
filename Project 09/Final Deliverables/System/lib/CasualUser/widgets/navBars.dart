import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
class BottomNavBar extends StatefulWidget {
  BottomNavBar(context);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String type = '';
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString("type");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
  }

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
                String page = '';
                if (type == "Simple User"){
                  page = '/home';
                }
                else if (type == "Shelter"){
                  page = '/shelterHome';
                }
                else if (type == "Vet"){
                  page = '/vetHome';
                }
                else if (type == "Seller"){
                  page = '/sellerHome';
                }
                Navigator.of(context, rootNavigator: true).pushNamed(page);
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
                Navigator.of(context, rootNavigator: true).pushNamed('/market');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset('assets/emergency-call.png',
                height: 28,
                width: 28,),
                ],
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed('/rescueMenu');
              }
          ),
          TextButton(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Icon(
                    Icons.chat_outlined,
                    color: Color.fromRGBO(84, 84, 84, .6),
                    size: 28
                  ),
                ],
              ),
              onPressed: () async{
                Navigator.of(context, rootNavigator: true).pushNamed('/feed');
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
              Navigator.of(context, rootNavigator: true).pushNamed('/profile');
            },
          ),
        ]
    );
  }
}

class HideableNavBar extends StatefulWidget {
  const HideableNavBar({ 
    Key key , 
    this.child,
    this.controller, 
    this.duration = const Duration(milliseconds:200)}) : super(key: key);
  final Widget child;
  final ScrollController controller;
  final Duration duration;


  @override
  State<HideableNavBar> createState() => _HideableNavBarState();
}

class _HideableNavBarState extends State<HideableNavBar> {
  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(listen);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     widget.controller.removeListener(listen);
  }
  void listen(){
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward){
      show();
    }
    else if (direction == ScrollDirection.reverse){
      hide();
    }
  }
  void show(){
    if (!isVisible){
    setState(() {
      isVisible = true;
    });
    }
  }
   void hide(){
    if (isVisible){
    setState(() {
      isVisible = false;
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight:0,
      child: Wrap(children: [widget.child],),
    );
  }
}

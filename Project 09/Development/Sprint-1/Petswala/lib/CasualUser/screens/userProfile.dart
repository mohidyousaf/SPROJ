import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/screens/settings.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

// This is a user profile screen that is divided into posts, about and shopping and settings.

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  double containerHeight = 150;
  double avatarHeight = 100;

  String name;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
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
    double top = containerHeight - avatarHeight / 2;
    return Scaffold(
      appBar: _topBar(context),
      body: Column(
        children: [
          _profile(top),
          SizedBox(height: 135),
          Container(
            // width: MediaQuery.of(context).size.width,
            child: ToggleSwitch(
              minWidth: 110,
              minHeight: 60.0,
              fontSize: 16.0,
              initialLabelIndex: 1,
              activeBgColor: [AppColor.primary],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey[100],
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 3,
              cornerRadius: 20,
              labels: ['Posts', 'About', 'Shopping'],
              icons: [Icons.post_add, Icons.info, Icons.shopping_bag],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          )
        ],
      ),
    );
  }

  AppBar _topBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Image.asset('assets/back.png'),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
      backgroundColor: AppColor.white,
      title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
      actions: [
        IconButton(
            icon: Icon(
              Icons.settings,
              color: AppColor.primary_dark,
            ),
            onPressed: () => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Settings()))
                })
      ],
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _profile(double top) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: containerHeight,
          decoration: BoxDecoration(color: AppColor.primary_light),
        ),
        Positioned(
          top: top + 50,
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            // color: AppColor.white,
            decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(1, 3))
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
        ),
        Positioned(
          left: 20,
          top: top,
          child: Container(
            child: CircleAvatar(
              radius: avatarHeight / 2 + 2,
              backgroundColor: AppColor.gray_light,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/User.png'),
                backgroundColor: AppColor.white,
                radius: avatarHeight / 2,
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
            left: 24,
            top: top + 120,
            child: Container(
                child: Row(
              children: [
                Text(
                  '  ' + name,
                  style: AppFont.h5(AppColor.black),
                ),
                // IconButton(
                //     onPressed: () => {
                //           // edit name
                //         },
                //      icon: Icon(Icons.edit)),
              ],
            ))),
        Positioned(
          top: top + 80,
          right: 16,
          child: GestureDetector(
            onTap: () {
              // switch the profile
            },
            child: Container(
              child: new Image.asset('assets/switch button.png'),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petswala/Authentication/addPet2.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/colors.dart';

// This is the UI part of add pet functionality where user can add his/her pet deatils, that is connected with BLoc that has the logic and updates the backend.

class AddPet extends StatefulWidget {
  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topbar(null),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Container(
            child: new Image.asset('assets/progress.png'),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: new Image.asset('assets/petowner.png'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Color.fromRGBO(255, 138, 128, 1),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Do you have a pet?',
                    style: ptextstyle(),
                  ),
                  SizedBox(height: 24),
                  buildButton2('+ ADD YOUR PET', Color.fromRGBO(85, 68, 119, 1),
                      context, AddPet2()),
                  SizedBox(height: 16),
                  buildButton2('I don\'t have a pet',
                      Color.fromRGBO(200, 90, 84, 1), context, Login()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

TextStyle ptextstyle() {
  return TextStyle(
      color: Color.fromRGBO(250, 250, 250, 1),
      fontFamily: 'Lato',
      fontSize: 20,
      letterSpacing: 0.75,
      fontWeight: FontWeight.normal,
      height: 1);
}

Widget topbar(function) {
  return AppBar(
    leading:
        IconButton(icon: Image.asset('assets/back.png'), onPressed: function),
    backgroundColor: AppColor.primary_light,
    title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
    centerTitle: true,
    elevation: 0,
  );
}

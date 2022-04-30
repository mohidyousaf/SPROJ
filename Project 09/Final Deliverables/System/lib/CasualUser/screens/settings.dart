import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/CasualUser/blocs/settingsBloc.dart';
import 'package:petswala/CasualUser/events/ChangeSettingsEvent.dart';
import 'package:petswala/CasualUser/events/addPetEvent.dart';
import 'package:petswala/CasualUser/screens/userProfile.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/Widgets/textfield.dart';
import 'package:petswala/name.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeSettingsBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserProfile())),
            icon: Image.asset('assets/back.png'),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text('Settings', style: AppFont.h4(AppColor.black)),
              SizedBox(height: 32),
              Row(
                children: [
                  Icon(Icons.account_circle_rounded, size: 30),
                  SizedBox(width: 8),
                  Text('Account', style: AppFont.h5(AppColor.black))
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(height: 16),
              ChangeWidget(
                text: 'Change UserName',
                title: 'Enter new UserName',
                label: 'New UserName',
              ),
              ChangeWidget(
                text: 'Change Email',
                title: 'Enter new Email',
                label: 'New Email',
              ),
              ChangeWidget(
                text: 'Change Password',
                title: 'Enter new Password',
                label: 'New Password',
              ),
              ChangeWidget(
                text: 'Become a Volunteer',
                title: 'Write Confirm',
                label: 'Your location will be used in this regards',
              ),
              SizedBox(height: 36),
              buildButton2("Log Out", AppColor.primary_dark, context, Login())
            ],
          ),
        ),
      ),
    );
  }

  Padding changewidget(text, title, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  title: Text(title),
                  content: Container(
                    height: 180,
                    child: Column(
                      children: [
                        TextField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: title,
                            labelText: label,
                          ),
                          onChanged: (value) {
                            // update password
                          },
                        ),
                        SizedBox(height: 30),
                        BuildButton(text: 'Confirm')
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(text, style: AppFont.bodySmall(AppColor.black)),
            IconButton(
                onPressed: () {
                  //edit
                },
                icon: Icon(Icons.arrow_right))
          ]),
          decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

class ChangeWidget extends StatefulWidget {
  final String text, title, label;
  ChangeWidget({this.text, this.title, this.label});

  @override
  _ChangeWidgetState createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChangeSettingsBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  title: Text(widget.title),
                  content: Container(
                    height: 180,
                    child: Column(
                      children: [
                        TextField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: widget.title,
                            labelText: widget.label,
                          ),
                          onChanged: (value) {
                            print('new value is ${value}');
                            // event
                            if (widget.title == 'Enter new UserName') {
                              bloc.add(ChangeUsernameEvent(newName: value));
                              print('change username event');
                            }

                            if (widget.title == 'Enter new Email') {
                              bloc.add(ChangeEmailEvent(newEmail: value));
                              print('change email event');
                            }

                            if (widget.title == 'Enter new Password') {
                              bloc.add(ChangePasswordEvent(newPassword: value));
                              print('change password event');
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        BuildButton(
                            text: 'Confirm',
                            type: widget.title,
                            context: this.context)
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.text, style: AppFont.bodySmall(AppColor.black)),
            IconButton(
                onPressed: () {
                  //edit
                },
                icon: Icon(Icons.arrow_right))
          ]),
          decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

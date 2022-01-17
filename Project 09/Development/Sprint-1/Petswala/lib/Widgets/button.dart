import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/CasualUser/blocs/settingsBloc.dart';
import 'package:petswala/CasualUser/events/ChangeSettingsEvent.dart';
import 'package:petswala/CasualUser/states/ChangeSettingsState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildButton extends StatefulWidget {
  String text, type;
  BuildContext context;
  BuildButton({this.text, this.type, this.context});

  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
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
    final bloc = BlocProvider.of<ChangeSettingsBloc>(widget.context);
    return GestureDetector(
      onTap: () {
        //TODO : Login
        if (widget.type == 'Enter new UserName') {
          bloc.add(ConfirmUsernameChangeEvent(currentName: name));
          // Navigator.pop(context, true);
        }
        if (widget.type == 'Enter new Email') {
          bloc.add(ConfirmEmailChangeEvent(currentName: name));
        }
        if (widget.type == 'Enter new Password') {
          print('i am here');
          bloc.add(ConfirmPasswordChangeEvent(currentName: name));
        }
        Navigator.pop(context, true);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text('Successfully updated'),
              );
            });
      },
      child: Container(
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(85, 68, 119, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Lato',
                  fontSize: 15,
                  letterSpacing: 1.25,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildButton(String text) {
  return GestureDetector(
    onTap: () => {
      //TODO : Login
    },
    child: Container(
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Color.fromRGBO(85, 68, 119, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Lato',
                fontSize: 15,
                letterSpacing: 1.25,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ],
      ),
    ),
  );
}

Widget buildButton2(String text, clr, context, destination) {
  return GestureDetector(
    onTap: () => {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => destination))
    },
    child: Container(
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: clr,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Lato',
                fontSize: 15,
                letterSpacing: 1.25,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/CasualUser/blocs/settingsBloc.dart';
import 'package:petswala/CasualUser/events/ChangeSettingsEvent.dart';
import 'package:petswala/CasualUser/screens/servicesHome.dart';
import 'package:petswala/CasualUser/states/ChangeSettingsState.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
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
      child: Expanded(
        child: Container(
          // width: 250,
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
      ),
    );
  }
}

Widget buildButton(String text, ServiceInfo service, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      // ignore: todo
      //TODO : Login
      // add end point logic here
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String name = prefs.getString('name');
      NetworkHandler nw = NetworkHandler();
      Map<String, String> body = {
        'veterinaryName': service.name,
        'personName': name,
        'rate': service.rate.toString(),
        'rating': service.rating.toString()
      };

      var res =
          await nw.post('appointment/addAppointment', body).then((value) => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        alignment: Alignment.bottomCenter,
                        backgroundColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 70,
                          width: 50,
                          child: Center(
                            child: Text('Booking successful',
                                style: AppFont.bodySmall(AppColor.white)),
                          ),
                        ),
                      );
                    })
              });

      print(service);

      await Future.delayed(const Duration(seconds: 1), () {});
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ServicesHome()));
    },
    child: Container(
      width: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: AppColor.primary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppFont.button(AppColor.white),
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

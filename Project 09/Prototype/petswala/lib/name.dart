import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petswala/Widgets/textfield.dart';
import 'package:petswala/Widgets/validationFunctions.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController Name = new TextEditingController();

  String type = '';
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValid = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      Map data = ModalRoute
          .of(context)
          .settings
          .arguments as Map;
      setState(() {
          type = data['type'] as String;
      });
    }
    return Scaffold(
        backgroundColor: Colors.white,
        //Creating the body of the page.
        body: Column(
          mainAxisSize: MainAxisSize.min,
          //Adding the header of the page.
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,40,8,20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,5,5),
                          child: Transform.rotate(
                            angle: -math.pi/4,
                            child: Icon(Icons.pets_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text('Petswala',
                          style:GoogleFonts.getFont('Bubblegum Sans',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w200
                          ),
                          textAlign: TextAlign.left
                          ,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,8,20,50),
                    child: Center(
                      child: Text(type=='user'?'What should we call you?':'Enter Name of Your Shop',
                        style:GoogleFonts.getFont('Gothic A1',
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left
                        ,),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 137, 137, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
              ),
            ),
            //Forming the data section of the page.
            Expanded(
              child: Form(
                autovalidateMode: autoValid,
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  //Creating all the text fields for data entry.
                  child: SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          InputTextFields(label: 'Name', controller:Name,
                              validateFunc: ValidationFunctions.validateEmpty),

                          SizedBox(height: 30.0),
                          Container(
                              height: 60.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromRGBO(255, 137, 137, 1),
                                // elevation: 7.0,
                                child: TextButton(
                                  onPressed: () async{
                                    if (_formKey.currentState.validate()) {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('name', Name.text.toString());
                                      prefs.setString('type', type);
                                      if (type == 'user'){
                                        Navigator.popAndPushNamed(context, '/home');
                                      }
                                      else{
                                        Navigator.popAndPushNamed(context, '/shop');
                                      }
                                    }
                                    else{
                                      setState((){
                                        autoValid = AutovalidateMode.always;
                                      });
                                      print('yoooooooooooo');
                                    }
                                  },
                                  //Creeating a button to save sign up information.
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

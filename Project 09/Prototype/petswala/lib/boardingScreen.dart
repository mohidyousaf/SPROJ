import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme: ThemeData(
      primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
        accentColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: Boarding()
  ));
}


class Boarding extends StatefulWidget {
  @override
  _BoardingState createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(100),
          ),

          Center(
            child: Text('Are you', style: GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0),fontSize: 25, fontWeight: FontWeight.bold )),
            ),
          ),

          SizedBox(height:50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                }, // handle your image tap here
                child: Image.asset(
                  'assets/User.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                }, // handle your image tap here
                child: Image.asset(
                  'assets/Owner.png',
                  fit: BoxFit.cover, // this is the solution for border
                  width: 110.0,
                  height: 110.0,
                  // color: Colors.red,
                ),
              ),
            ],
          ),

          Row(
            children : <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(105, 20, 10, 0),
                child: Text('User', style: GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0),fontSize: 15 ))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(105, 20, 10, 0),
                child: Text('Shop Owner', style: GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0),fontSize: 15 ))),
              ),
           ]
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
        accentColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: Profile()
  ));
}


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Figma Flutter Generator Rectangle1Widget - RECTANGLE
          // Figma Flutter Generator Rectangle71Widget - RECTANGLE
          // Figma Flutter Generator Rectangle1Widget - RECTANGLE
          // Figma Flutter Generator Rectangle71Widget - RECTANGLE
          Expanded(
            child: Container(
              padding: EdgeInsets.all(40),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Image.asset('assets/logo.png'),

                    CircleAvatar(
                      backgroundImage: AssetImage('assets/User.png'),
                      backgroundColor:Colors.white,
                      radius: 40.0,
                    ),
                    Text('Chun-Li', style: GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0),fontSize: 25, fontWeight: FontWeight.bold )))
                  ],
                ),
                // width: 80,
                // height: 200,
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color : Color.fromRGBO(255, 131, 127, 1).withOpacity(0.9),
                )
            ),
          ),


          Center(
            child: ToggleSwitch(
              minWidth: 200.0,
              minHeight: 90.0,
              fontSize: 16.0,
              initialLabelIndex: 1,
              activeBgColor: [Colors.green],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 3,
              labels: ['Posts', 'Likes', 'Followings'],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
          Spacer(),

          Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home_filled, color: Color.fromRGBO(11, 71, 109, 1.0), size: 24.0,),
                        Text('Home', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/reportsHome');
                    }
                ),
                TextButton(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, color: Color.fromRGBO(11, 71, 109, 1.0), size: 24.0,),
                        Text('Edit', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
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
                      Icon(Icons.supervised_user_circle, size: 24.0,color: Color.fromRGBO(11, 71, 109, 1.0),),
                      Text('Profile', style:
                      GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0))),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/inventory');
                  },
                ),
              ]
          )

        ],
      ),
    );
  }
}

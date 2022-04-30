import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petswala/Widgets/Search.dart';
import 'package:petswala/Widgets/productCard.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
//         accentColor: Colors.white,
//         textTheme: GoogleFonts.latoTextTheme(),
//       ),
//       home:Shop2()
//   ));
// }


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Product> products =[
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Image.asset('assets/logo.png'),

                    SearchBar(),

                    // CircleAvatar(
                    //   backgroundImage: AssetImage('assets/User.png'),
                    //   backgroundColor:Colors.white,
                    //   radius: 40.0,
                    // ),
                    // Text('Chun-Li', style: GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0),fontSize: 25, fontWeight: FontWeight.bold )))
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('No pets found',
                  style:GoogleFonts.getFont('Gothic A1',
                      fontSize: 36,
                      color: Colors.black45,
                      fontWeight: FontWeight.w200
                  ),
                  textAlign: TextAlign.center
                  ,),
          )
        ],
      ),
    );
  }
}

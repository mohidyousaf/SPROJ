//import 'dart:js';

import 'package:petswala/DataBase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    // initialRoute: '/InventoryReport',
    // initialRoute: '/expenses1',
    debugShowCheckedModeBanner:false,
    routes: {
      // '/': (context) =>

    },
    theme: ThemeData(
      primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
      accentColor: Colors.white,
      textTheme: GoogleFonts.latoTextTheme(),
    ),

  ));
}


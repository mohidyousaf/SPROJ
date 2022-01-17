import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/Authentication/addPet2.dart';
import 'package:petswala/CasualUser/screens/userProfile.dart';
import 'package:petswala/CasualUser/screens/userMarketplace.dart';
import 'package:petswala/bloc/pet_bloc.dart';
import 'package:petswala/bloc/register_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/boardingScreen.dart';
import 'package:petswala/map.dart';
import 'package:petswala/underMaintenance.dart';
import 'package:petswala/Seller/screens/shopInventory.dart';
import 'package:petswala/SearchPage.dart';
import 'package:petswala/addItem.dart';
import 'package:petswala/name.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/Authentication/landingPage.dart';
import 'package:petswala/CasualUser/screens/newsFeed.dart';
import 'package:petswala/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HttpOverrides.global = new DevHttpOverrides();
  if (prefs.containsKey('name')) {
    var name = prefs.getString('name');
    var type = prefs.getString('type');
    print(name);
    print(type);
  }
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // providers are used for providing instance of blocs to all the underneath context
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBLoc>(create: (context) => RegisterBLoc()),
        Provider<PetBLoc>(create: (context) => PetBLoc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          // These are all the routes , which will used in navigation
          '/': (context) => LandingPage(),
          // '/': (context) => Shop(),
          '/name': (context) => Name(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => UserProfile(),
          '/rescue': (context) => RescueMap(),
          '/maintenance': (context) => Maintenance(),
          '/shop': (context) => Shop(),
          '/market': (context) => UserMarketplace(),
          '/search': (context) => Search(),
          '/feed': (context) => NewsFeed(),
          '/addItem': (context) => AddItem(),
          '/login': (context) => Login(),
          '/boarding': (context) => Boarding(),
          '/addpet1': (context) => AddPet(),
          '/addpet2': (context) => AddPet2(),
        },
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      height: 200,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.red[300],
        elevation: 7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              //ImagrOverLay: AssetImage('assets/dogcollor.jpg'),
              //Image(image: AssetImage('assets/dogcollor.jpg'),
              leading: Icon(Icons.pets, size: 60),
              title: Text('Dog Collar', style: TextStyle(fontSize: 25.0)),
              subtitle: Text(
                  'size: M   '
                  'quantity:10\n'
                  'Price: Rs50\n ',
                  style: TextStyle(fontSize: 18.0)),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Edit'),
                  onPressed: () {/* ... */},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {/* ... */},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

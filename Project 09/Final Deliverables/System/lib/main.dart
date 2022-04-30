import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/Authentication/addPet2.dart';
import 'package:petswala/CasualUser/screens/adoption.dart';
import 'package:petswala/CasualUser/screens/rescue.dart';
import 'package:petswala/CasualUser/screens/rescueMenu.dart';
import 'package:petswala/CasualUser/screens/rescueRequests.dart';
import 'package:petswala/CasualUser/screens/servicePage.dart';
import 'package:petswala/CasualUser/screens/servicesHome.dart';
import 'package:petswala/CasualUser/screens/userProfile.dart';
import 'package:petswala/CasualUser/screens/userMarketplace.dart';
import 'package:petswala/CasualUser/screens/vetHome.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/Seller/screens/addProduct.dart';
import 'package:petswala/Seller/screens/shopProductPage.dart';
import 'package:petswala/Shelter/screens/shelterHome.dart';
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
import 'package:petswala/Seller/screens/shop.dart';
import 'package:petswala/Seller/screens/home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  log('ffd');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HttpOverrides.global = new DevHttpOverrides();
  if (prefs.containsKey('name')) {
    var name = prefs.getString('name');
    var type = prefs.getString('type');
    debugPrint(name);
    print(type);
  }
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatform();
    sendnotification();
  }

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
          // '/': (context) => ServicesHome(),
          // '/': (context) => UserProfile(),
          // '/':(context) => ShelterHome(),
          '/': (context) => LandingPage(),
          '/name': (context) => Name(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => UserProfile(),
          '/rescueMenu': (context) => RescueMenu(),
          '/rescue': (context) => RescueHome(),
          '/rescueRequests': (context) => RescueRequests(),
          '/maintenance': (context) => Maintenance(),
          '/shop': (context) => ShopProvider(),
          '/productPage': (context) => ProductPage(),
          '/market': (context) => UserMarketplace(),
          '/search': (context) => Search(),
          '/feed': (context) => NewsFeed(),
          '/addProduct': (context) => AddProduct(),
          '/login': (context) => Login(),
          '/boarding': (context) => Boarding(),
          '/addpet1': (context) => AddPet(),
          '/addpet2': (context) => AddPet2(),
          '/serviceHome': (context) => ServicesHome(),
          '/servicePage': (context) => ServicePage(),
          '/shelterHome': (context) => ShelterHome(),
          '/sellerHome':(context) => SellerHome(),
          '/vetHome': (context) => VetHome(),
          '/adoption': (context) => AdoptionRouter(),

        },
      ),
    );
  }
}

Future<void> initPlatform() async {
  await OneSignal.shared.setAppId("085fe5f1-7940-4ee0-8447-704b42ae861d");
  await OneSignal.shared
      .getDeviceState()
      .then((value) => {print(value.userId)});
}

sendnotification() async {
  NetworkHandler nw = NetworkHandler();
  nw.get('notification/SendNotification');
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

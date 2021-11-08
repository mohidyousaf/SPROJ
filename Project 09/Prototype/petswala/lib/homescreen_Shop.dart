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
//       home:Shop()
//   ));
// }


class Shop extends StatefulWidget {

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Product> products =[
    Product(productName: 'brush', quantity: 50, price: 20),
    Product(productName: 'cage', quantity: 30, price: 40),
    Product(productName: 'food', quantity: 40, price: 100),
    Product(productName: 'door', quantity: 40, price: 20)
  ];
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
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
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
            ),
          ),

          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: products.map((prod)=>  MyCardWidget(prod: prod)).toList()
                )
              ),
            ),
          )

        ],
      ),
    );
  }
}

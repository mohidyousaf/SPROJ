import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petswala/Widgets/Search.dart';
import 'package:petswala/Widgets/productCard.dart';
import 'package:petswala/addItem.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
    Product(productName: 'Brush', quantity: 50, price: 20),
    Product(productName: 'Cage', quantity: 30, price: 40),
    Product(productName: 'Food', quantity: 40, price: 100),
    Product(productName: 'Door', quantity: 40, price: 20)
  ];
  List<Product> pets =[
    Product(productName: 'Cats', quantity: 50, price: 20),
    Product(productName: 'Dogs', quantity: 30, price: 40),
    Product(productName: 'Rabbits', quantity: 40, price: 100),
    Product(productName: 'Hamster', quantity: 40, price: 20)
  ];
  bool value=true;
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
                      // TextButton(
                      //   onPressed: (){
                      //     Navigator.pushNamed(context, '/addItem', arguments: {'inventory':widget.inventory});
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(15)),
                      //       border: Border.all()
                      //     ),
                      //     child: Text('Add New Item'),
                      //   ),
                      // )

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
            child
                : SingleChildScrollView(
child: Column(
              children: <Widget>[
               Padding(
                 padding: EdgeInsets.all(20),
               child:  buildSwitch(),
              ),

              Container(

                padding: EdgeInsets.all(40),
                child:  Column(

                  children: value ? pets.map((prod_)=>  MyCardWidget(prod: prod_)).toList() : products.map((prod_a)=>  MyCardWidget(prod: prod_a)).toList()
                )
              )
                  ]
              ),
              ),
          )

            ]
      ),
          );

  }

  Widget buildSwitch()=> Transform.scale(
    scale: 2,
    child: ToggleSwitch(
      minWidth: 60.0,
      minHeight: 20.0,
      fontSize: 8.0,
      initialLabelIndex: 1,
      activeBgColor: [Color.fromRGBO(255, 131, 127, 1).withOpacity(0.9)],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.grey[900],
      totalSwitches: 2,
      labels: ['Pets', 'Accessories'],
      onToggle: (value) {
        print('switched to: $value');
      },
    ),
    // child: Switch.adaptive(
    //

    //   value: value,
    //   onChanged: (value) => setState(() => this.value = value),
    // ),
  );
 }
//   @override
//   State<StatefulWidget> createState() {
//     //
//     throw UnimplementedError();
//   }
//
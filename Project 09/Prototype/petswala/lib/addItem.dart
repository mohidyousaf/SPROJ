//The Sign Up Page
//This page allows the user to create their account.

// import 'package:asaanrozgar/Widgets/validationFunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DataBase.dart';
import 'package:petswala/Widgets/textfield.dart';
import 'package:petswala/Widgets/validationFunctions.dart';
import 'dart:math' as math;
import 'package:petswala/Widgets/productCard.dart';

import 'Widgets/productCard.dart';

//The parent class for Sign Up.
class AddItem extends StatefulWidget {
  // This widget is the root of your application.
  Inventory inventory = Inventory();

  // AddItem({required this.inventory});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController Name = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  TextEditingController Quantity = new TextEditingController();
  // TextEditingController Password = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValid = AutovalidateMode.disabled;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //Creating the body of the page.
      body: Column(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add a New Item',
                    style:GoogleFonts.getFont('Gothic A1',
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w200
                    ),
                    textAlign: TextAlign.left
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child:Icon(Icons.camera_alt_rounded, size: 60, color: Color.fromRGBO(255, 137, 137, 1),)
                    ),
                  ),
                )
              ],
            ),
            height: 300,
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
                        InputTextFields(label: 'Item name', controller:Name,
                            validateFunc: ValidationFunctions.validateNoSpace),
                        SizedBox(height: 20.0),
                        InputTextFields(label: 'Price', controller:Price,
                            validateFunc: ValidationFunctions.validateEmpty),
                        InputTextFields(label: 'Quantity', controller:Quantity,
                            validateFunc: ValidationFunctions.validateEmpty),

                        SizedBox(height: 50.0),
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
                                    // widget.inventory.addNewItem(Price.text, Name.text, Quantity.text);
                                    Navigator.popAndPushNamed(context, '/shop');
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
                                    'Add Item',
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

class Inventory{
  List<Product> inventory = [];
  addNewItem(price, name, quantity){
    inventory.add(Product(price:int.parse(price), productName:name, quantity: int.parse(quantity)));
  }

}
class Item{
  double price;
  String name;
  Item({this.price:0, this.name:""});
}

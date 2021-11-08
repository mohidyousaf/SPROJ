import 'package:flutter/material.dart';

// void main() => runApp(MyCardWidget());

class Product{
  String productName;
  int quantity;
  int price;

  Product({required this.productName, required this.quantity, required this.price});

}


class MyCardWidget extends StatelessWidget {
  // MyCardWidget({Key? key}) : super(key: key);
  final Product prod;
  MyCardWidget({required this.prod});


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

                ListTile(

                  //ImagrOverLay: AssetImage('assets/dogcollor.jpg'),
                  //Image(image: AssetImage('assets/dogcollor.jpg'),
                  leading: Icon(Icons.pets, size: 60),
                  title: Text(
                      prod.productName,
                      style: TextStyle(fontSize: 25.0)
                  ),
                  subtitle: Text(
                      'size: M   '
                          'quantity:${prod.quantity}\n'
                          'Price: Rs${prod.price}\n ',
                      style: TextStyle(fontSize: 18.0)
                  ),
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
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}

class MyCardWidget2 extends StatelessWidget {
  // MyCardWidget({Key? key}) : super(key: key);
  final Product prod;
  MyCardWidget2({required this.prod});


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

                ListTile(

                  //ImagrOverLay: AssetImage('assets/dogcollor.jpg'),
                  //Image(image: AssetImage('assets/dogcollor.jpg'),
                  leading: Icon(Icons.pets, size: 60),
                  title: Text(
                      prod.productName,
                      style: TextStyle(fontSize: 25.0)
                  ),
                  subtitle: Text(
                      'size: M   '
                          'quantity:${prod.quantity}\n'
                          'Price: Rs${prod.price}\n ',
                      style: TextStyle(fontSize: 18.0)
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
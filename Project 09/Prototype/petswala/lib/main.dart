import 'package:flutter/material.dart';
//import 'package:toggle_bar/toggle_bar.dart';
import 'package:petswala/database2.dart' as server;

void main(){
   server.start; 
   runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Inventory')),

          // ToggleBar(
          //     labels: ["Pets", "Accessories"],
          //     onSelectionUpdated: (index) => // switch frm pets to accessories
          // )
        body: MyCardWidget(),
        //body: MyCardWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key? key}) : super(key: key);

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
                  title: Text(
                      'Dog Collar',
                      style: TextStyle(fontSize: 25.0)
                  ),
                  subtitle: Text(
                       'size: M   '
                          'quantity:10\n'
                      'Price: Rs50\n ',
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
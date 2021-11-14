import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      'mongodb+srv://ayan:abcd1234@clusterzero.nxzak.mongodb.net/Users?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('Users');
  //print (await coll.find().toList());
  // Create server
  const port = 8081;
  final serv = Sevr();

  final corsPaths = ['/', '/:id'];
  for (var route in corsPaths) {
    serv.options(route, [
      (req, res) {
        setCors(req, res);
        return res.status(200);
      }
    ]);
  }

  serv.get('/AllProducts/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      dynamic coll1 = db.collection('Products');
      final products = await coll1.find().toList();
      return res.status(200).json({'Products': products});
    }
  ]);

  serv.post('/PSProducts/', [
    setCors,
    (ServRequest req, ServResponse res) async {
      dynamic found  = await db.collection("Products").find({"storename":req.body['storename']}).toList();; 
      return res.status(200).json({'Products': found});
    }
  ]);

  serv.post('/AddProduct', [
      setCors,
      (ServRequest req, ServResponse res) async {
        await db.collection('Products').insertOne({"productname":req.body['productname'], "storename":req.body['storename'],'price':req.body['price'],'quantity':req.body['quantity']}); //add storename and fix address capslock
        return res.json(
          await db.collection('Products').findOne(where.eq('name', req.body['name'])),
        );
      }
    ]);

    serv.delete('/RemoveProduct/:name', [
      setCors,
      (ServRequest req, ServResponse res) async {
        await db.collection('Products').remove(where.eq('storename', ObjectId.fromHexString(req.params['name'])));
        return res.status(200);
      }
    ]);

  

  // Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}

void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'package:petswala/Widgets/productCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DBConnection {

  static DBConnection _instance;

  final String _getConnectionString = "mongodb+srv://ayan:abcd1234@clusterzero.nxzak.mongodb.net/Users?retryWrites=true&w=majority";

  Db _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = await Db.create(_getConnectionString);
        await _db.open();
      } catch(e){
        print('hfd');
        print(e);
      }
    }
    return _db;
  }

  Future getAllProducts() async{
    if (_db == null){
      await getConnection();
    }
    dynamic coll1 = _db.collection('Products');
    final products = await coll1.find().toList();
    List<Product> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(Product(productName:element['productname'], price:int.parse(element['price']), quantity:int.parse(element['quantity'])));
    });
    return finalList;
  }

  Future getShopProducts() async{
    if (_db == null){
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')){
      var name = prefs.getString('name');
      var type = prefs.getString('type');
      print(name);
      print(type);
    }
    dynamic coll1 = _db.collection('Products');
    List products = await coll1.find({"storename":name}).toList();
    List<Product> finalList = [];
    var poignant = products.forEach((element) {
      finalList.add(Product(productName:element['productname'], price:int.parse(element['price']), quantity:int.parse(element['quantity'])));
    });
    return finalList;
  }

  addProduct(productName, price, quantity) async{
    if (_db == null){
      await getConnection();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = '';
    if (prefs.containsKey('name')){
      var name = prefs.getString('name');
      var type = prefs.getString('type');
      print(name);
      print(type);
    }
    await _db.collection('Products').insertOne({"productname":productName, "storename":name,'price':price,'quantity':quantity}); //add storename and fix address capslock

  }

  closeConnection() {
    _db.close();
  }
}
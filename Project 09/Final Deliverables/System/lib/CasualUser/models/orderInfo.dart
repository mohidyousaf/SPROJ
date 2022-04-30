import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/models/productItem.dart';

class OrderItem {
  ObjectId id;
  ObjectId userID;
  String name;
  DateTime time;
  String status;
  String address;
  String city;
  String country;
  List<ProductItem> cartItems;

  OrderItem({this.id, this.userID, this.name:'', this.time, this.status:'incomplete', this.address, this.city, this.country, this.cartItems: const []});


}
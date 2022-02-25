import 'package:mongo_dart/mongo_dart.dart';

class ShopProductItem {
  ObjectId id;
  String name;
  String category;
  int quantity;
  double price;
  double rating;
  String imageUrl;

  ShopProductItem(
      {this.id,
      this.name,
      this.category,
      this.quantity,
      this.price,
      this.rating,
      this.imageUrl: 'assets/cat.png'});
}
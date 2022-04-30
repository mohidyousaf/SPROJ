import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:quiver/core.dart';

class ProductItem {
  ObjectId id;
  String name;
  String category;
  double price;
  double rating;
  int quantity;
  String imageUrl;
  String age;

  // bool operator == (other){
  //   return this.id == other.id && this.quantity == other.quantity;
  // }
  // int get hashCode => this.id.hashCode + this.quantity.hashCode;

  ProductItem(
      {this.id,
      this.name,
      this.category,
      this.price,
      this.rating,
      this.quantity: 0,
      this.imageUrl: 'assets/cat.png',
      this.age});
}

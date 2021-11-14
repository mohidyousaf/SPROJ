class Storeitem {
  final String id;
  final String storename;
  final int quantity;
  final int price;
  final String productname;

  const Storeitem._(this.id, this.storename, this.quantity, this.price, this.productname);

  factory Storeitem.fromJson(Map json) {
    final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final storename = json['storename'];
    final productname = json['productname'];
    final quantity = json['quantity'];
    final price = json['price'];
    return Storeitem._(id, storename, quantity, price, productname);
  }
}
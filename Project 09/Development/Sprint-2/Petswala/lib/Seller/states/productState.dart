import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';

class ProductState extends Equatable {
  final ObjectId id;
  final bool editable;
  final ShopProductItem product;


  @override
  List<Object> get props => [id, product, editable, isValid];

  ProductState._({this.id, this.product, this.editable:false, this.isValid:true});

  bool get passIsValid => product != null ? product.name.length > 3: true;

  final bool isValid;

  factory ProductState.initial(
      {ObjectId id, ShopProductItem product, bool editable}) {
    return ProductState._(
        id: id, product:product, editable: editable, isValid: product == null ? true :product.name.length > 3);
  }
}

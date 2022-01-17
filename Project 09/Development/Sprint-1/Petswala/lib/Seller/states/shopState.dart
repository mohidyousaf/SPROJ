import 'package:equatable/equatable.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';

class ShopState extends Equatable {
  final String selected;
  final List<ShopProductItem> products;
  final List<ShopProductItem> displayedProducts;

  @override
  List<Object> get props => [selected, displayedProducts];

  ShopState._(
      {this.selected: 'All',
      this.products: const [],
      this.displayedProducts: const []});

  factory ShopState.initial(
      {List<ShopProductItem> products: const [],
      List<ShopProductItem> displayedProducts: const []}) {
    return ShopState._(
        products: products, displayedProducts: displayedProducts);
  }
}

import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/productItem.dart';

class MarketPlaceState extends Equatable {
  final String selected;
  final List<ProductItem> products;
  final List<ProductItem> displayedProducts;

  @override
  List<Object> get props => [selected, displayedProducts];

  MarketPlaceState._(
      {this.selected: 'All',
      this.products: const [],
      this.displayedProducts: const []});

  factory MarketPlaceState.initial(
      {List<ProductItem> products: const [],
      List<ProductItem> displayedProducts: const []}) {
    return MarketPlaceState._(
        products: products, displayedProducts: displayedProducts);
  }
}

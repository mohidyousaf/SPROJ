import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/orderInfo.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
class MarketPlaceState extends Equatable{
  final String selected;
  final List<ProductItem> products;
  final List<ProductItem> displayedProducts;
  final OrderItem order;

  get props => [selected, products, displayedProducts, order.cartItems, order.name, order.address, order.city, order.country];

  double get getCartTotal => order.cartItems.fold(0, (prev, curr) => prev + (curr.price*curr.quantity));

  MarketPlaceState._(
      {this.selected: 'All',
      this.products: const [],
      this.order,
      this.displayedProducts: const []});

  factory MarketPlaceState.initial({
    List<ProductItem> products: const [], 
    List<ProductItem> displayedProducts: const [], 
    List<ProductItem> cartItems: const [],
    String firstName:'',
    String lastName:'',
    String address:'',
    String city:'',
    String country:''}) {
    OrderItem order = OrderItem(
      time: DateTime.now(), 
      cartItems: cartItems,
      name: firstName+' '+lastName,
      address: address,
      city: city,
      country: country);
    return MarketPlaceState._(
        products: products, displayedProducts: displayedProducts, order: order);
  }
}


import 'package:bloc/bloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/demo.dart';

class MarketPlaceBloc extends Bloc<MarketPlaceEvent, MarketPlaceState> {
  MarketPlaceBloc() : super(MarketPlaceState.initial()) {
    on<ChangeSelectionEvent>((event, emit) {
      List<ProductItem> displayedProducts = state.products
          .where((element) =>
              element.category == event.category || event.category == 'All')
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts, cartItems: state.order.cartItems));
    });
    on<ProductSearchEvent>((event, emit) {
      var text = event.searchString.toLowerCase();
      List<ProductItem> displayedProducts = state.products
          .where((element) => element.name.toLowerCase().startsWith(text))
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts, cartItems: state.order.cartItems));
    });
    on<InitializeListEvent>((event, emit) async {
      List<ProductItem> products = await getAllProducts();
      emit(MarketPlaceState.initial(
          products: products, displayedProducts: products, cartItems: []));
    });
    on<RefreshListEvent>((event, emit) async {
      List<ProductItem> products = await getAllProducts();
      emit(MarketPlaceState.initial(
          products: products, displayedProducts: products, cartItems: state.order.cartItems));
    });
    on<AddToCartEvent>((event, emit) async {
      List<ProductItem> cart = state.order.cartItems;
      if (!cart.contains(state.displayedProducts[event.index])){
        state.displayedProducts[event.index].quantity = 1;
        cart.add(state.displayedProducts[event.index]);
        }

      cart.forEach((element) {print(element.name);});
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: state.displayedProducts, cartItems: cart));

    });
    on<RemoveFromCartEvent>((event, emit) async {
      state.order.cartItems.removeAt(event.index);
    });
    on<IncQuantityEvent>((event, emit) async {
      state.order.cartItems[event.index].quantity += 1;
      this.add(RefreshListEvent());

    });
    on<DecQuantityEvent>((event, emit) async {
      if(state.order.cartItems[event.index].quantity > 0)
      {state.order.cartItems[event.index].quantity -= 1;}
      this.add(RefreshListEvent());

    });
    on<ConfirmOrderEvent>((event, emit) async {
      emit(MarketPlaceState.initial(
          products: state.products, 
          displayedProducts: state.displayedProducts, 
          cartItems: state.order.cartItems,
          firstName: event.firstName,
          lastName: event.lastName,
          address: event.address,
          city: event.city,
          country: event.country));
      print(event.firstName);

    });

    on<AddOrderEvent>((event, emit) async {
      await addOrder(state.order);

    });

    
  }
  Future getAllProducts() async {
    var db = await DBConnection.getInstance();
    var products = await db.getAllProducts();
    return products;
  }
  Future addOrder(order) async {
    var db = await DBConnection.getInstance();
    await db.addOrder(order);

  }
}

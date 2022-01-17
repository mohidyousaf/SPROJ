import 'package:bloc/bloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/demo.dart';

class MarketPlaceBloc extends Bloc<MarketPlaceEvent, MarketPlaceState> {
  List<ProductItem> list = [];
  MarketPlaceBloc() : super(MarketPlaceState.initial()) {
    on<ChangeSelectionEvent>((event, emit) {
      List<ProductItem> displayedProducts = state.products
          .where((element) =>
              element.category == event.category || event.category == 'All')
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts));
    });
    on<ProductSearchEvent>((event, emit) {
      var text = event.searchString.toLowerCase();
      List<ProductItem> displayedProducts = state.products
          .where((element) => element.name.toLowerCase().startsWith(text))
          .toList();
      emit(MarketPlaceState.initial(
          products: state.products, displayedProducts: displayedProducts));
    });
    on<InitializeListEvent>((event, emit) async {
      List<ProductItem> products = await getAllProducts();
      emit(MarketPlaceState.initial(
          products: products, displayedProducts: products));
    });
  }
  Future getAllProducts() async {
    var db = await DBConnection.getInstance();
    var products = await db.getAllProducts();
    return products;
  }
}

import 'package:bloc/bloc.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/states/shopState.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:petswala/demo.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  List<ShopProductItem> list = [];
  ShopBloc() : super(ShopState.initial()) {
    on<ProductSearchEvent>((event, emit) {
      var text = event.searchString.toLowerCase();
      List<ShopProductItem> displayedProducts = state.products
          .where((element) => element.name.toLowerCase().startsWith(text))
          .toList();
      emit(ShopState.initial(
          products: state.products, displayedProducts: displayedProducts));
    });
    on<InitializeListEvent>((event, emit) async {
      List<ShopProductItem> products = await getShopProducts();
      emit(ShopState.initial(
          products: products, displayedProducts: products));
    });
  }
  Future getShopProducts() async {
    var db = await DBConnection.getInstance();
    var products = await db.getShopProducts();
    return products;
  }
}

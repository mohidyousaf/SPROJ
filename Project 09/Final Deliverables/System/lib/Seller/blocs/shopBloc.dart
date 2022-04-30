import 'package:bloc/bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/states/shopState.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:petswala/demo.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  
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
      emit(ShopState.initial(loading: true));
      List<ShopProductItem> products = await getShopProducts();
      emit(ShopState.initial(
          products: products, displayedProducts: products));
    });
    on<RefreshListEvent>((event, emit) async {
      List<ShopProductItem> products = await getShopProducts();
      emit(ShopState.initial(
          products: products, displayedProducts: products));
    });
    on<DeleteProductEvent>((event, emit) async {
      ObjectId productID = state.displayedProducts[event.index].id;
      await deleteShopProduct(productID);
      add(RefreshListEvent());
    });
    

  }
  Future  deleteShopProduct(ObjectId productID) async{
      var db = await DBConnection.getInstance();
      await db.deleteShopProduct(productID);
  }
  Future getShopProducts() async {
    var db = await DBConnection.getInstance();
    var products = await db.getShopProducts();
    return products;
  }
}

import 'package:bloc/bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/Seller/events/productEvent.dart';
import 'package:petswala/Seller/states/productState.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:petswala/demo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  
  ProductBloc() : super(ProductState.initial()) { 
    on<InitProductEvent>((event, emit) async {
      ShopProductItem product = await getProduct(id:event.id);
      emit(ProductState.initial(
          product: product, id: event.id, editable: false));
    });
    on<AddProductEvent>((event, emit) async {
      await addProduct(state.product);
    });
    on<MakeEditableEvent>((event, emit) {
      print('kjjj');
      emit(ProductState.initial(
          product: state.product, id: state.id, editable: true));
    });
    on<CompleteEditEvent>((event, emit) async{
      print('kjjj');
      await editProduct(state.id, state.product);
      emit(ProductState.initial(
          product: state.product, id: state.id, editable: false));
      
    });
    on<ChangeNameEvent>((event, emit) {
      ShopProductItem product = state.product;
      product.name = event.name;

      emit(ProductState.initial(
          product: product, id: state.id, editable: true));
    });
    on<ChangeCategoryEvent>((event, emit) {
      ShopProductItem product = state.product;
      product.category = event.category;
      emit(ProductState.initial(
          product: product, id: state.id, editable: true));
    });
    on<ChangePriceEvent>((event, emit) {
      ShopProductItem product = state.product;
      product.price = double.parse(event.price);
      emit(ProductState.initial(
          product: product, id: state.id, editable: true));
    });
    on<ChangeQuantityEvent>((event, emit) {
      ShopProductItem product = state.product;
      product.quantity = int.parse(event.quantity);
      emit(ProductState.initial(
          product: product, id: state.id, editable: true));
    });
  }
  Future getProduct({id}) async {
    if (id == null){
      return ShopProductItem(
        name: '',
        category: '',
        quantity: 0,
        price: 0.0,
        rating: 0.0
      );
    }
    var db = await DBConnection.getInstance();
    var product = await db.getProduct(id);

    return product;
  }
  editProduct(id, product) async {
    var db = await DBConnection.getInstance();
    await db.editProduct(id, product);
  }
  addProduct(product) async {
    var db = await DBConnection.getInstance();
    await db.addProduct(product);
  }
}
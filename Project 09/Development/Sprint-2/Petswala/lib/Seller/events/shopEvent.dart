abstract class ShopEvent {}

class ProductSearchEvent extends ShopEvent {
  String searchString;
  ProductSearchEvent({this.searchString});
}
class InitializeListEvent extends ShopEvent {
  InitializeListEvent();
}
class RefreshListEvent extends ShopEvent {
  RefreshListEvent();
}
class DeleteProductEvent extends ShopEvent {
  int index;
  DeleteProductEvent({this.index});
}
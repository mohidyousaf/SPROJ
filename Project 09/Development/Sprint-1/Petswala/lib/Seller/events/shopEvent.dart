abstract class ShopEvent {}

class ProductSearchEvent extends ShopEvent {
  String searchString;
  ProductSearchEvent({this.searchString});
}
class InitializeListEvent extends ShopEvent {
  InitializeListEvent();
}
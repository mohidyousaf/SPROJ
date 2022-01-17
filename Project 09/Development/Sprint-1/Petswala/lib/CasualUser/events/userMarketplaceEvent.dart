abstract class MarketPlaceEvent {}

class ChangeSelectionEvent extends MarketPlaceEvent {
  String category;
  ChangeSelectionEvent({this.category});
}
class ProductSearchEvent extends MarketPlaceEvent {
  String searchString;
  ProductSearchEvent({this.searchString});
}
class InitializeListEvent extends MarketPlaceEvent {
  InitializeListEvent();
}
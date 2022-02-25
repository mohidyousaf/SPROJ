import 'package:mongo_dart/mongo_dart.dart';

abstract class ProductEvent {}

class InitProductEvent extends ProductEvent {
  final ObjectId id;
  InitProductEvent({this.id});
}
class AddProductEvent extends ProductEvent {
  AddProductEvent();
}
class ChangeNameEvent extends ProductEvent {
  final String name;
  ChangeNameEvent({this.name});
}
class ChangeCategoryEvent extends ProductEvent {
  final String category;
  ChangeCategoryEvent({this.category});
}
class ChangePriceEvent extends ProductEvent {
  final String price;
  ChangePriceEvent({this.price});
}
class ChangeQuantityEvent extends ProductEvent {
  final String quantity;
  ChangeQuantityEvent({this.quantity});
}
class IncQuantityEvent extends ProductEvent {
  IncQuantityEvent();
}
class DecQuantityEvent extends ProductEvent {
  DecQuantityEvent();
}

class MakeEditableEvent extends ProductEvent {
  MakeEditableEvent();
}
class CompleteEditEvent extends ProductEvent {
  CompleteEditEvent();
}
abstract class CheckoutEvent {}

class ChangeFirstNameEvent extends CheckoutEvent {
  final String name;
  ChangeFirstNameEvent({this.name});
}
class ChangeSecondNameEvent extends CheckoutEvent {
  final String name;
  ChangeSecondNameEvent({this.name});
}
class ChangeAddressEvent extends CheckoutEvent {
  final String address;
  ChangeAddressEvent({this.address});
}
class ChangeCityEvent extends CheckoutEvent {
  final String city;
  ChangeCityEvent({this.city});
}
class ChangeCountryEvent extends CheckoutEvent {
  final String country;
  ChangeCountryEvent({this.country});
}

import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String country;


  @override
  List<Object> get props => [firstName, lastName, address, city, country];

  CheckoutState._({this.firstName, this.lastName, this.address, this.city, this.country});

  // bool get passIsValid => Checkout != null ? Checkout.name.length > 3: true;

  // final bool isValid;

  factory CheckoutState.initial(
      {String firstName,String lastName,String address,String city,String country,}) {
    return CheckoutState._(
        firstName: firstName, lastName: lastName, address: address, city: city, country: country);
  }
}

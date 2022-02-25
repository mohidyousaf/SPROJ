import 'package:bloc/bloc.dart';
import 'package:petswala/CasualUser/events/checkoutEvent.dart';
import 'package:petswala/CasualUser/states/checkoutState.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  
  CheckoutBloc() : super(CheckoutState.initial()) { 
    on<ChangeFirstNameEvent>((event, emit) {
      print(event.name);
      emit(CheckoutState.initial(
        firstName: event.name,
        lastName: state.lastName, 
        address: state.address,
        city: state.city,
        country: state.country));
     
    });
    on<ChangeSecondNameEvent>((event, emit) {
      emit(CheckoutState.initial(
        firstName: state.firstName, 
        lastName: event.name, 
        address: state.address,
        city: state.city,
        country: state.country));
     
    });
    on<ChangeAddressEvent>((event, emit) {
      emit(CheckoutState.initial(
        firstName: state.firstName, 
        lastName: state.lastName, 
        address: event.address,
        city: state.city,
        country: state.country));
  
    });
    on<ChangeCityEvent>((event, emit) {
      emit(CheckoutState.initial(
        firstName: state.firstName, 
        lastName: state.lastName, 
        address: state.address,
        city: event.city,
        country: state.country));
    
    });
    on<ChangeCountryEvent>((event, emit) {
      emit(CheckoutState.initial(
        firstName: state.firstName, 
        lastName: state.lastName, 
        address: state.address,
        city: state.city,
        country: event.country));
    });

  }
}
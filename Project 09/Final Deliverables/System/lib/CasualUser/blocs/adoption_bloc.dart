import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:petswala/CasualUser/events/adoption_event.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';
import 'package:petswala/CasualUser/states/adoption_state.dart';
import 'package:petswala/demo.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
   Future getAllPets() async {
    var db = await DBConnection.getInstance();
    var pets = await db.getAllAdoptionPets();
    return pets;
  }
  AdoptionBloc() : super(AdoptionState.initial()) {
      on<ChangeSelectionEvent>((event, emit) {
        log('dsdss');
        List<PetInfo> displayedPets = state.pets
          .where((element) =>
              element.category == event.category || event.category == 'All')
          .toList();
        emit(AdoptionState.initial(
          pets: state.pets, displayedPets: displayedPets));
    });
    on<PetSearchEvent>((event, emit) {
    //   var text = event.searchString.toLowerCase();
    //   List<ProductItem> displayedProducts = state.products
    //       .where((element) => element.name.toLowerCase().startsWith(text))
    //       .toList();
    //   emit(MarketPlaceState.initial(
    //       products: state.products, displayedProducts: displayedProducts, cartItems: state.order.cartItems));
    });
    on<InitializeListEvent>((event, emit) async {
      print('fdfdfffd');
      emit(AdoptionState.initial(
          loading: true));
      List<PetInfo> pets = await getAllPets();
      emit(AdoptionState.initial(
          pets: pets, displayedPets: pets));
    });
    on<RefreshListEvent>((event, emit) async {
      List<PetInfo> pets = await getAllPets();
      emit(AdoptionState.initial(
          pets: pets, displayedPets: pets));
    });
    on<ViewPetEvent>((event, emit) async {
      
    });
    on<FavPetEvent>((event, emit) async {
      
    });
  }
}

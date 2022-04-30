import 'package:bloc/bloc.dart';
import 'package:petswala/Shelter/events/adoption_event.dart';
import 'package:petswala/Shelter/states/adoption_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  AdoptionBloc() : super(AdoptionInitial()) {
    on<AdoptionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

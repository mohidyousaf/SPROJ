import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/events/vet_event.dart';
import 'package:petswala/CasualUser/states/vet_state.dart';
import 'package:petswala/Repository/networkHandler.dart';

class VetBloc extends Bloc<VetEvent, VetState> {
  VetBloc() : super(VetInitial()) {
    on<InitializeAppointmentEvent> ((event, emit) async{
      NetworkHandler nw= NetworkHandler();
      var resp= await nw.get('appointment/${event.name}');
            // TODO: implement event handler
    });
  }
}

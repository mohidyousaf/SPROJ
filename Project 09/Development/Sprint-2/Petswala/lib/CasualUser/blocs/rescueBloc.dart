
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/events/rescueEvent.dart';
import 'package:petswala/CasualUser/models/rescueInfo.dart';
import 'package:petswala/CasualUser/states/rescueState.dart';
import 'package:petswala/demo.dart';

class RescueBloc extends Bloc<RescueEvent, RescueState> {
  RescueBloc() : super(RescueState.initial()) {
    on<ChangeContactEvent>((event, emit) {
      emit(RescueState.initial(contact:event.contact,
        petType: state.petType, 
        description: state.description, 
        pos: state.pos, 
        controller: state.controller));
      
    });
    on<ChangeLocationEvent>((event, emit) {
      print('${event.lat}, ${event.long}');
      emit(RescueState.initial(pos: LatLng(event.lat, event.long), controller: state.controller));
      
    });
    on<ChangePetEvent>((event, emit) {
      print(event.petType);
      emit(RescueState.initial(contact:state.contact,
        petType: event.petType, 
        description: state.description, 
        pos: state.pos, 
        controller: state.controller));
      
    });
    on<ChangeDescriptionEvent>((event, emit) {
      emit(RescueState.initial(contact:state.contact,
        petType: state.petType, 
        description: event.text, 
        pos: state.pos, 
        controller: state.controller));
      
    });
    on<MapInitializationEvent>((event, emit) {
      emit(RescueState.initial(pos: event.pos, controller: event.controller));  
      add(ChangeLocationEvent(lat:event.pos.latitude, long: event.pos.longitude));
    });
    on<PostRescueEvent>((event, emit) async{
      await addRescueRequest(state.contact, state.pos, state.description, state.petType);
      emit(RescueState.initial(
        request: true,
        contact:state.contact,
        petType: state.petType, 
        description: state.description, 
        pos: state.pos, 
        controller: state.controller));
    });
  }
  addRescueRequest(contact, location, description, petType) async {
    var db = await DBConnection.getInstance();
    RescueInfo rescue = RescueInfo(contact:contact, description:description, petType:petType, pos:location);
    await db.addRescueRequest(rescue);
    print('done');
  }
}
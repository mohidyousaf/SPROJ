import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/events/rescueRequestEvent.dart';
import 'package:petswala/CasualUser/models/rescueInfo.dart';
import 'package:petswala/CasualUser/states/rescueRequestState.dart';
import 'package:petswala/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RescueRequestBloc extends Bloc<RescueRequestEvent, RescueRequestState> {
  List<RescueInfo> list = [];
  RescueRequestBloc() : super(RescueRequestState.initial()) {
    on<InitializationEvent>((event, emit) async {
      List<RescueInfo> requests = await getAllRescues();
      emit(RescueRequestState.initial(
          requests: requests));
    });
  }

  Future getAllRescues() async {
    var db = await DBConnection.getInstance();
    var requests = await db.getAllRequests();
    return requests;
  }
}

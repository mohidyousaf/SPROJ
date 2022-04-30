import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RescueState extends Equatable {

  final LatLng pos;
  final String contact;
  final String petType;
  final String description;
  final bool requestSubmitted;
  final GoogleMapController controller;
  final bool loading;
  @override
  List<Object> get props => [loading, pos, controller, requestSubmitted, description, petType, contact]; 

  RescueState._({this.loading:false,this.pos, this.controller, this.contact, this.description, this.petType, this.requestSubmitted:false});

  factory RescueState.initial({bool loading:false, LatLng pos, GoogleMapController controller, String contact, String description, String petType, bool request:false}) {
    return RescueState._(loading:loading,pos: pos, controller: controller, contact: contact, description: description, petType: petType, requestSubmitted: request);
  }
}

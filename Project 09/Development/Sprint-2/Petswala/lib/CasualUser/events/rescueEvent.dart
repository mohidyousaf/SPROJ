import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petswala/CasualUser/screens/rescue.dart';

abstract class RescueEvent{}

class ChangeContactEvent extends RescueEvent {
  final String contact;
  ChangeContactEvent({this.contact});
}
class ChangeLocationEvent extends RescueEvent {
  final double lat;
  final double long;
  ChangeLocationEvent({this.lat, this.long});
}
class ChangePetEvent extends RescueEvent {
  final String petType;
  ChangePetEvent({this.petType});
}
class ChangeDescriptionEvent extends RescueEvent {
  final String text;
  ChangeDescriptionEvent({this.text});
}
class MapInitializationEvent extends RescueEvent {
  final GoogleMapController controller;
  final LatLng pos;
  MapInitializationEvent({this.controller, this.pos});
}
class PostRescueEvent extends RescueEvent {
  PostRescueEvent();
}
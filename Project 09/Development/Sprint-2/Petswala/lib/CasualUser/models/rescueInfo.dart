

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RescueInfo {
  String contact;
  String name;
  String description;
  String petType;
  LatLng pos;

  RescueInfo({this.name, this.contact, this.description, this.petType, this.pos});
}
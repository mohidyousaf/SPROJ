import 'package:equatable/equatable.dart';

abstract class VetEvent{
  const VetEvent();
}

class InitializeAppointmentEvent extends VetEvent{
  String name;
  InitializeAppointmentEvent({this.name});
}



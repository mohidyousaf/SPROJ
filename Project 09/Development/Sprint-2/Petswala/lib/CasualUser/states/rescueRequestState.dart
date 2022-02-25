import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/rescueInfo.dart';

class RescueRequestState extends Equatable {
  final List<RescueInfo> requests;

  @override
  List<Object> get props => [requests]; 

  RescueRequestState._({this.requests: const []});

  factory RescueRequestState.initial(
      {List<RescueInfo> requests: const []}) {
    return RescueRequestState._(requests: requests);
  }
}

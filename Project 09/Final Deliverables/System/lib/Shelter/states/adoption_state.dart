import 'package:equatable/equatable.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();
  
  @override
  List<Object> get props => [];
}

class AdoptionInitial extends AdoptionState {}

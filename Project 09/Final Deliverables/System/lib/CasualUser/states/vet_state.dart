import 'package:equatable/equatable.dart';

abstract class VetState extends Equatable {
  const VetState();
  
  @override
  List<Object> get props => [];
}

class VetInitial extends VetState {}

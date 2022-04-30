
import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';

class AdoptionState extends Equatable{
  final List<PetInfo> pets;
  final List<PetInfo> displayedPets;
  final bool loading;
  @override
  List<Object> get props => [pets, displayedPets, loading]; 

  AdoptionState._({this.pets: const [], this.displayedPets: const [], this.loading});

  factory AdoptionState.initial(
      {List<PetInfo> pets: const [], List<PetInfo> displayedPets: const [], bool loading:false}) {
    return AdoptionState._(pets: pets, displayedPets: displayedPets, loading: loading);
  }

}

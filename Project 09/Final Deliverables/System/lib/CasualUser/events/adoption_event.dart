import 'package:equatable/equatable.dart';

abstract class AdoptionEvent{
  const AdoptionEvent();
}

class ChangeSelectionEvent extends AdoptionEvent {
  String category;
  ChangeSelectionEvent({this.category});
}
class PetSearchEvent extends AdoptionEvent {

}
class InitializeListEvent extends AdoptionEvent {
  InitializeListEvent();

}
class RefreshListEvent extends AdoptionEvent {

}
class ViewPetEvent extends AdoptionEvent {

}
class FavPetEvent extends AdoptionEvent {

}

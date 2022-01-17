abstract class AddPetEvent {}

// These are the possible events when user add pets

class ChangeCategoryEvent extends AddPetEvent {
  String category;

  ChangeCategoryEvent({this.category});
}

class ChangeNameEvent extends AddPetEvent {
  String name;
  ChangeNameEvent({this.name});
}

class ChangeAgeEvent extends AddPetEvent {
  String age;

  ChangeAgeEvent({this.age});
}

class SubmitEvent extends AddPetEvent {}

abstract class AddPetEvent {}

// These are the possible events when user can call on adding pets

class ChangePathEvent extends AddPetEvent {
  String path;
  ChangePathEvent({this.path});
}

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

abstract class PostEvent {}

class AddPostEvent extends PostEvent {}

class InitializationEvent extends PostEvent {}

class ChangeNewPostTextEvent extends PostEvent {
  String text;

  ChangeNewPostTextEvent({this.text});
}

class LikePostEvent extends PostEvent {
  int index;

  LikePostEvent({this.index});
}

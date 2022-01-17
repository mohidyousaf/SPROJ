import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/postInfo.dart';

class PostState extends Equatable {
  final List<PostInfo> posts;
  String newPostText = ' ';

  @override
  List<Object> get props => [posts]; 

  PostState._({this.posts: const []});

  factory PostState.initial(
      {List<PostInfo> posts: const []}) {
    return PostState._(posts: posts);
  }
}

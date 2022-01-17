import 'package:mongo_dart/mongo_dart.dart';

class PostInfo{
  final ObjectId postID;
  final String posterName;
  final String posterType;
  final String text;
  final DateTime time;
  final int likes;
  final List<dynamic> likeList;
  bool liked;
  
  PostInfo({this.postID, this.posterName, this.posterType, this.text:'', this.time, this.likes:0, this.likeList:const [], this.liked});
}
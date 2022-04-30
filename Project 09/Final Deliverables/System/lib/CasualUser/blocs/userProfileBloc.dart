import 'package:bloc/bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/events/userProfileEvent.dart';
import 'package:petswala/CasualUser/models/postInfo.dart';
import 'package:petswala/CasualUser/models/userInfo.dart';
import 'package:petswala/CasualUser/states/postState.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petswala/CasualUser/states/userProfileState.dart';
import 'package:petswala/CasualUser/events/userProfileEvent.dart';
import 'package:petswala/CasualUser/models/userInfo.dart';

class userProfileBloc extends Bloc<userProfileEvent,UserInfoState>{
  List<ProductItem> list = [];
  userProfileBloc(): super(UserInfoState.initial()){

    on<InitializeUserInfo>((event,emit) async {
      await emit(UserInfoState.initial(user: UserInformation(contact_no: "0300555443",email: "mohidyousaf@gmail.com",Address: "Nowhere" )));
    });

}
}
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//   List<ProductItem> list = [];
//   PostBloc() : super(PostState.initial()) {
//     on<InitializationEvent>((event, emit) async {
//       List<PostInfo> posts = await getAllPosts();
//       emit(PostState.initial(
//           posts: posts));
//     });
//
//     on<AddPostEvent>((event, emit) async {
//       await addPost(state.newPostText);
//       this.add(InitializationEvent());
//     });
//     on<ChangeNewPostTextEvent>((event, emit) async {
//       state.newPostText = event.text;
//     });
//
//     on<LikePostEvent>((event, emit) async {
//       int newLikes = state.posts[event.index].likes;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String name = '';
//       String action = 'add';
//       if (prefs.containsKey('name')) {
//         name = prefs.getString('name');
//       }
//       if (state.posts[event.index].likeList.contains(name)){
//         newLikes -=1;
//         action = 'remove';
//       }
//       else{
//         newLikes += 1;
//       }
//       ObjectId postID = state.posts[event.index].postID;
//       await likePost(newLikes, postID, action);
//       this.add(InitializationEvent());
//
//     });
//   }
//   likePost(likes, postID, action) async{
//     var db = await DBConnection.getInstance();
//     if (action == 'add'){
//       await db.addLike(postID, likes);
//     }
//     else if (action == 'remove'){
//       await db.removeLike(postID, likes);
//     }
//
//     print('done');
//   }
//   addPost(text) async {
//     var db = await DBConnection.getInstance();
//     await db.addPost(text);
//     print('done');
//   }
//   Future getAllPosts() async {
//     var db = await DBConnection.getInstance();
//     var posts = await db.getAllPosts();
//     return posts;
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:petswala/CasualUser/models/postInfo.dart';
import 'package:petswala/CasualUser/models/userInfo.dart';

class UserInfoState extends Equatable {
  final UserInformation user;

  @override
  List<Object> get props => [user];

  UserInfoState._({this.user});

  factory UserInfoState.initial(
      {UserInformation user}) {
    return UserInfoState._(user: user);
  }
}


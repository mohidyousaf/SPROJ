import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';

abstract class userProfileEvent {}

class InitializeUserInfo extends userProfileEvent{}

class ChangeUserProfile extends userProfileEvent{
  String userprofile;
  ChangeUserProfile({this.userprofile});
}


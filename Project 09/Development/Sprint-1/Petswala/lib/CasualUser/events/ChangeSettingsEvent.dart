import 'package:flutter_bloc/flutter_bloc.dart';

// These are the possible events when user can call on changing settings

abstract class ChangeSettingsEvent {}

class ChangeUsernameEvent extends ChangeSettingsEvent {
  String newName;
  ChangeUsernameEvent({this.newName});
}

class ChangePasswordEvent extends ChangeSettingsEvent {
  String newPassword;
  ChangePasswordEvent({this.newPassword});
}

class ChangeEmailEvent extends ChangeSettingsEvent {
  String newEmail;
  ChangeEmailEvent({this.newEmail});
}

class ConfirmUsernameChangeEvent extends ChangeSettingsEvent {
  String currentName;
  ConfirmUsernameChangeEvent({this.currentName});
}

class ConfirmPasswordChangeEvent extends ChangeSettingsEvent {
  String currentName;
  ConfirmPasswordChangeEvent({this.currentName});
}

class ConfirmEmailChangeEvent extends ChangeSettingsEvent {
  String currentName;
  ConfirmEmailChangeEvent({this.currentName});
}

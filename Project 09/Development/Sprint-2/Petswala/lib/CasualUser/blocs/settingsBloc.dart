import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/events/ChangeSettingsEvent.dart';
import 'package:petswala/CasualUser/states/ChangeSettingsState.dart';
import 'package:petswala/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// It contains bloc logic for listening to the events eg changing name, password or email and then respond accordinig to the events and emit changes in the state.

class ChangeSettingsBloc
    extends Bloc<ChangeSettingsEvent, ChangeSettingsState> {
  ChangeSettingsBloc() : super(ChangeSettingsState()) {
    on<ConfirmUsernameChangeEvent>((event, emit) async {
      final db = await DBConnection.getInstance();
      db.changeUsername(event.currentName, state.newUsername);
      //updating new name
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', state.newUsername);
      print('in confirm state');
    });

    on<ConfirmPasswordChangeEvent>((event, emit) async {
      final db = await DBConnection.getInstance();
      db.changePassword(event.currentName, state.newPassword);
      //updating new password
      print('in confirm state');
    });

    on<ConfirmEmailChangeEvent>((event, emit) async {
      final db = await DBConnection.getInstance();
      db.changeEmail(event.currentName, state.newEmail);
      //updating new email
      print('in confirm state');
    });

    on<ChangeUsernameEvent>((event, emit) {
      emit(state..newUsername = event.newName);
      print('new user name state is ${state..newUsername}');
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(state..newPassword = event.newPassword);
      print('new passwod state is ${state..newPassword}');
    });

    on<ChangeEmailEvent>((event, emit) async {
      emit(state..newEmail = event.newEmail);
      print('new email state is ${state..newPassword}');
    });
  }
}

import 'package:petswala/bloc/validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:petswala/demo.dart';

// It contains stream controllers for registering users that listen all the changes from the textfield and update the information in databse.

class RegisterBLoc with Validator {
  // stream controllers
  final _userName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // getters
  Stream<String> get userName => _userName.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);

  Stream<bool> get isValid =>
      Rx.combineLatest3(userName, email, password, (a, b, c) => true);

  //setters
  Function(String) get changeUserNAme => _userName.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  //logic for resgitsering and adding details to the database

  void submit() async {
    print(_userName.value);
    print(_email.value);
    print(_password.value);
    var db = await DBConnection.getInstance();
    var user = await db.addUser(_userName.value, _email.value, _password.value);
  }

  //dispose streams
  void dispose() {
    _userName.close();
    _email.close();
    _password.close();
  }
}

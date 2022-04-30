import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/bloc/validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:petswala/demo.dart';

// It contains stream controllers for registering users that listen all the changes from the textfield and update the information in databse.

class RegisterBLoc with Validator {
  // stream controllers
  final _userName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _type = BehaviorSubject<String>();

  // getters
  Stream<String> get userName => _userName.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get type => _type.stream;

  Stream<bool> get isValid =>
      Rx.combineLatest3(userName, email, password, (a, b, c) => true);

  //setters
  Function(String) get changeUserNAme => _userName.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeType => _type.sink.add;

  //logic for resgitsering and adding details to the database

  NetworkHandler nw = NetworkHandler();

  void submit() async {
    print(_userName.value);
    print(_email.value);
    print(_password.value);
    print(_type.value);
    Map<String, String> data = {
      'name': _userName.value,
      'email': _email.value,
      'password': _password.value,
      'type': _type.value
    };

    print(data);
    var db = await DBConnection.getInstance();
    nw.post('user/register', data);
    // var user = await db.addUser(_userName.value, _email.value, _password.value);
  }

  //dispose streams
  void dispose() {
    _userName.close();
    _email.close();
    _password.close();
    _type.close();
  }
}

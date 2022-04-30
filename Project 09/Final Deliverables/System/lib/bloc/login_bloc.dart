import 'dart:convert';
import 'dart:core';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/bloc/validation_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is login bloc of our application where all the login logic is implemented that triggers updates in the states and fetch information from the backend and verify if
// it is a authentic user.

class LoginBloc with Validator_login {
// define controllers
  final _loginUserName = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();
  final _loginState = BehaviorSubject<bool>();
  // final _client = StreamChatClient('pz93j7x2ygtm', logLevel: Level.INFO);
// define getters

  Stream<String> get userName => _loginUserName.stream.transform(nameValidator);
  Stream<String> get password =>
      _loginPassword.stream.transform(passwordValidator);

  Stream<bool> get loginState => _loginState.stream;

  Stream<bool> get isValid =>
      Rx.combineLatest2(userName, password, (a, b) => true);

  // setters

  Function(String) get changeUserName => _loginUserName.sink.add;
  Function(String) get changePassword => _loginPassword.sink.add;

// password submission

  NetworkHandler nw = NetworkHandler();
  final storage = new FlutterSecureStorage();

  Future<Tuple2> submit() async {
    // final userID = _loginUserName.value;

    // Map<String, String> body = {'userId': userID};
    // var tokenResponse = await nw.post('streamClient/token', body);
    // var userToken = jsonDecode(tokenResponse.body)['token'];

    // await _client.connectUser(User(id: userID), userToken).then((response) {
    //   print(response);
    // });
    var temp = [];
    print(_loginPassword.value);
    print(_loginUserName.value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _loginUserName.value);
    String testName = _loginUserName.value;
    String testPassword = _loginPassword.value;
    // print(users[0].name);
    Map<String, String> data = {'name': testName, 'password': testPassword};

    //api call
    var response = await nw.post('user/login', data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result['token']);
      print(result['type']);
      temp.add(result['type']);
      await storage.write(key: 'token', value: result['token']);
      temp.add(true);
      return new Tuple2(true, result['type']);
      // return true;
    } else {
      var output = json.decode(response.body);
      print(output);
      temp.add(false);
      return new Tuple2(false, 'none');
      // return false;
    }
  }

// dispose
  void dispose() {
    _loginPassword.close();
    _loginUserName.close();
    _loginState.close();
  }
}

class Tuple2 {
  final bool val;
  final String text;

  Tuple2(this.val, this.text);
}

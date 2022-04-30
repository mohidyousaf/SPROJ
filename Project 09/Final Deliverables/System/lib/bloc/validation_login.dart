import 'dart:async';

import 'package:petswala/Repository/networkHandler.dart';

// Here i am doing all the validation for the text field that are transformed to the streams and all the errors are combined to give either true or false and unlock the
// login button
NetworkHandler nw = NetworkHandler();

mixin Validator_login {
  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) async {
      if (name.isEmpty) {
        sink.addError("Username can't be empty");
      }

      if (name.length < 3) {
        sink.addError('User name should be greater than 3');
      } else {
        sink.add(name);
      }
    },
  );

  var passwordValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (pass.isEmpty) {
      sink.addError('Password can\'t be empty');
    }

    if (pass.length < 3) {
      sink.addError('Password Length can not be smaller than 3');
    } else {
      sink.add(pass);
    }
  });

  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.isEmpty) {
      sink.addError('Email Field can not be empty');
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(data)) {
      sink.addError("Enter a Valid Email");
    } else {
      sink.add(data);
    }
  });

  // var loginValidation =
  //     StreamTransformer<bool, String>.fromHandlers(handleData: (login, sink) {
  //   if (!login) {
  //     sink.addError('User Name or Password is wrong');
  //   } else {
  //     sink.add(login);
  //   }
  // });
}

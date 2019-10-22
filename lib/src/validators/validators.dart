import 'dart:async';

class Validators {
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (_validateUsername(username)) {
      sink.add(username);
    } else {
      sink.addError('Entera valid username');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (_validatePassword(password)) {
      sink.add(password);
    } else {
      sink.addError('Enter a valid password');
    }
  });
}

bool _validateUsername(username) {
  return username.length > 1 ? true : false;
}

bool _validatePassword(password) {
  return true;
}

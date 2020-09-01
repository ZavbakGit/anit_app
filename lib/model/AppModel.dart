import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';

class AppModel{
  User _user;
  LoginData _loginData;

  final DateTime dateTime = DateTime.now();

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  LoginData get loginData => _loginData;

  set loginData(LoginData value) {
    _loginData = value;
  }
}
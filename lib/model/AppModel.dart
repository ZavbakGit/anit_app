import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';
import 'package:anit_app/services/api_provider.dart';

class AppModel{
  User _user;

  LoginData _loginData;
  ApiProvider _apiProvider;
  bool _isAuth = false;

  User get user => _user;
  LoginData get loginData => _loginData;
  bool get isAuth => _isAuth;

  void auth(User user,LoginData loginData){
    this._user = user;
    this._loginData = loginData;
    _apiProvider = ApiProvider(loginData: loginData);
  }


}
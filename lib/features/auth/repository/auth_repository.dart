import 'dart:convert';

import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';
import 'package:anit_app/model/user_setting.dart';
import 'package:anit_app/services/api_provider.dart';
import 'package:anit_app/services/preferences_provider.dart';
import 'package:http/http.dart';

class AuthRepository {
  static const _LOGIN_KEY = 'LOGIN_KEY';
  static const _PASSWORD_KEY = 'PASSWORD_KEY';

  Future<User> auth({LoginData loginData}) async {
    final apiProvider = ApiProvider(loginData: loginData);

    final url = 'auth';

    final Response response = await apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);
    final user = User.fromJson(json.decode(bodyUtf8));
    return user;
  }

  Future<UserSetting> getSetting({String userGuid, LoginData loginData}) async {
    final apiProvider = ApiProvider(loginData: loginData);

    final url = 'setting?user=$userGuid';

    final Response response = await apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);
    final userSetting = UserSetting.fromJson(json.decode(bodyUtf8));
    return userSetting;
  }

  Future<LoginData> getLoginFromSettings() async {
    //await Future.delayed(Duration(milliseconds: 3000));
    final login = await PreferencesProvider.getValue(_LOGIN_KEY);
    final password = await PreferencesProvider.getValue(_PASSWORD_KEY);

    return LoginData(login: login, password: password);
  }

  Future<bool> setLoginFromSettings(LoginData loginData) async {
    //await Future.delayed(Duration(milliseconds: 3000));
    final user =
        await PreferencesProvider.setValue(_LOGIN_KEY, loginData.login);
    final pass =
        await PreferencesProvider.setValue(_PASSWORD_KEY, loginData.password);
    return user & pass;
  }
}

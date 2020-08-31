import 'dart:convert';

import 'package:anit_app/model/login_data.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final LoginData loginData;

  ApiProvider({this.loginData});

  static final _anitBaseUri = 'http://172.31.255.150/erp_anit/hs/api_anit';
  static const _timeout = 5;

  Map<String, String> _getHeader(String user, String pass) {
    final _auth = 'Basic ' + base64Encode(utf8.encode('$user:$pass'));

    return {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': _auth
    };
  }

  Future<Response> request({String uri})  {
    final _url = '$_anitBaseUri/$uri';

    return http
        .get(_url, headers: _getHeader(loginData.login, loginData.password))
        .timeout(const Duration(seconds: _timeout))
        .then(_checkStatusCode);
  }
}

Response _checkStatusCode(Response response){
  if (response.statusCode != 200){
    throw Exception('Error status code: ${response.statusCode}');
  }else{
    return response;
  }
}

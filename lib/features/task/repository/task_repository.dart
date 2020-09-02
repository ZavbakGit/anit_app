import 'dart:convert';
import 'package:anit_app/features/task/model/task.dart';
import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/services/api_provider.dart';
import 'package:http/http.dart';

class TaskRepository {
  final ApiProvider _apiProvider;

  TaskRepository(LoginData _loginData)
      : this._apiProvider = ApiProvider(loginData: _loginData);

  Future<Task> getTask(String guid) async {
    final url = 'task?guid=$guid';

    final Response response = await _apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);

    return Task.fromJson(json.decode(bodyUtf8));
  }
}

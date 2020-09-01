import 'dart:convert';
import 'package:anit_app/features/tasks/model/tasks.dart';
import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/services/api_provider.dart';
import 'package:http/http.dart';

class TasksRepository {
  final ApiProvider _apiProvider;

  TasksRepository(LoginData _loginData)
      : this._apiProvider = ApiProvider(loginData: _loginData);

  Future<List<TaskItem>> getListTaskItem(String guid) async {
    final url = 'tasks?user=$guid';

    final Response response = await _apiProvider.request(uri: url);
    final bodyUtf8 = utf8.decode(response.bodyBytes);

    return ResponseTasks.fromJson(json.decode(bodyUtf8)).tasks;
  }
}

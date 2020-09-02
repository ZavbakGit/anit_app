import 'package:anit_app/model/login_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/auth_start.dart';
import 'features/task/task_start.dart';
import 'features/tasks/tasks_start.dart';
import 'model/AppModel.dart';
import 'model/user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return MaterialApp(
      routes: {
        '/': (context) => AuthStartFeature(
              successListener: (User user, LoginData loginData) {
                Future.delayed(Duration.zero, () {
                  appModel.loginData = loginData;
                  appModel.user = user;
                  Navigator.pushReplacementNamed(context, '/tasks');
                });
              },
            ),
        '/tasks': (context) => TasksStartFeature(),
        '/task': (context) => TaskStartFeature()
      },
      initialRoute: '/',
    );
  }
}

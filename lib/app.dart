import 'package:anit_app/model/login_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/auth_start.dart';
import 'features/searchctalog/search_catalog_start.dart';
import 'features/task/task_start.dart';
import 'features/tasks/tasks_start.dart';
import 'model/AppModel.dart';
import 'model/user.dart';
import 'model/user_setting.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);

    //ToDo Похорошему надо сделать отдельный клас в который будт переключать и передавать параметры

    return MaterialApp(
      routes: {
        '/': (context) => AuthStartFeature(
              successListener: (User user, LoginData loginData,UserSetting userSetting) {
                Future.delayed(Duration.zero, () {
                  appModel.loginData = loginData;
                  appModel.userSetting = userSetting;
                  appModel.user = user;
                  Navigator.pushReplacementNamed(context, '/tasks');
                });
              },
            ),
        '/tasks': (context) => TasksStartFeature(),
        '/task': (context) => TaskStartFeature(),
        '/search_catalog':(context) => SearchCatalogStartFeature()
      },
      initialRoute: '/',
    );
  }
}

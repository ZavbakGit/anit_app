import 'package:anit_app/model/login_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/auth/auth_start.dart';
import 'features/tasks/tasks_start.dart';
import 'model/user.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => AuthStartFeature(
              successListener: (User user, LoginData loginData) {
                Navigator.pushReplacementNamed(context, '/tasks');
              },
            ),
        '/tasks': (context) => TaskStartFeature()
      },
      initialRoute: '/',
    );
  }
}

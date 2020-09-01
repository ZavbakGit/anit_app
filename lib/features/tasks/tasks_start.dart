
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskStartFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Задачи ${appModel.user?.name??''}'),
      ),
    );
  }
}
import 'package:anit_app/features/task/view/task_page.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/Catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/task_bloc.dart';
import 'model/task.dart';

class TaskStartFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);

    RouteSettings settings = ModalRoute.of(context).settings;
    final argument = settings.arguments;

    if (argument is String) {
      return BlocProvider(
        create: (context) => TaskBloc(appModel, argument),
        child: TaskPage(),
      );
    } else if (argument is Catalog) {
      final task = Task()
        ..date = DateTime.now()
        ..groupTask = argument
        ..director = Catalog(type: 'Пользователи')
        ..responsible = Catalog(type: 'Пользователи')
        ..partner = Catalog(type: 'Партнеры');

      return BlocProvider(
        create: (context) => TaskBloc.newTask(appModel, task),
        child: TaskPage(),
      );
    }
  }
}

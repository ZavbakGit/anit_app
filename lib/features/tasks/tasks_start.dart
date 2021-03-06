import 'package:anit_app/features/tasks/view/tasks_page.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/tasks_bloc.dart';

class TasksStartFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return BlocProvider(
      create: (context) => TasksBloc(appModel),
      child: TasksPage(),
    );
  }
}

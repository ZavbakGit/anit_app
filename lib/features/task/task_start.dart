import 'package:anit_app/features/task/view/task_page.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/task_bloc.dart';



class TaskStartFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    RouteSettings settings = ModalRoute.of(context).settings;
    final guidTask = settings.arguments;
    return BlocProvider(
      create: (context) => TaskBloc(appModel,guidTask),
      child: TaskPage(),
    );
  }
}

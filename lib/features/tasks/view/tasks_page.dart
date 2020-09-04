import 'package:anit_app/common/util/date_utils.dart';
import 'package:anit_app/common/view/choose_radio_button_dialog.dart';
import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/tasks/bloc/tasks_bloc.dart';
import 'package:anit_app/features/tasks/bloc/tasks_event.dart';
import 'package:anit_app/features/tasks/bloc/tasks_state.dart';
import 'package:anit_app/features/tasks/model/tasks.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/Catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    final List<Catalog> listGroup = appModel?.userSetting?.listGroupTask ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await showDialog(
              context: context,
              builder: (context) => ChooseRadioButtonDialog(
                    list: List<String>.generate(
                        listGroup.length, (index) => listGroup[index].name),
                    currentValue: 0,
                  ));
          if (value != null) {
            Navigator.pushNamed(context, '/task', arguments: listGroup[value]);
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        semanticsLabel: 'Обновить',
        onRefresh: () async {
          BlocProvider.of<TasksBloc>(context).add(InitialEvent());
          return null;
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is InitialState) {
                  BlocProvider.of<TasksBloc>(context).add(InitialEvent());
                  return Text('');
                }

                if (state is ProgressState) {
                  return ProgressWidget();
                }

                if (state is ErrorState) {
                  return ListView(
                    children: <Widget>[
                      Text(''),
                      Text('Error: ${state.errorMessage}'),
                      Text(''),
                      Text(''),
                    ],
                  );
                }

                if (state is ShowListState) {
                  return _listTaskItem(state.listItem);
                }

                return Text('Unknown state: ${state.toString()}');
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _listTaskItem(List<TaskItem> list) {
  return ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) => GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/task', arguments: list[index].guid);
      },
      child: Card(
        child: ListTile(
          title: Text('${list[index].description}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('${list[index].partner}'),
                    flex: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('${list[index].date.getDaysPassed()} д'),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${list[index].responsible}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              )
            ],
          ),
          dense: true,
          isThreeLine: true,
        ),
      ),
    ),
  );
}

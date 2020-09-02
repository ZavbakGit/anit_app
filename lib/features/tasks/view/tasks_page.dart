import 'package:anit_app/common/util/date_utils.dart';
import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/tasks/bloc/tasks_bloc.dart';
import 'package:anit_app/features/tasks/bloc/tasks_event.dart';
import 'package:anit_app/features/tasks/bloc/tasks_state.dart';
import 'package:anit_app/features/tasks/model/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SingingCharacter { lafayette, jefferson }

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSimpleDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(title: Text('Группа'), children: <Widget>[
              RadioListTile(
                title: Text('Долги'),
                value: 1,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
              RadioListTile(
                title: Text('Поручение'),
                value: 2,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              )
            ]);
          });
    }

    void _showSimpleDialog1() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Группа'),
              content: Container(
                child: Column(children: <Widget>[
                  RadioListTile(
                    title: Text('Долги'),
                    value: 1,
                    onChanged: (value) {
                      //Navigator.pop(context, value);
                    },
                  ),
                  RadioListTile(
                    title: Text('Поручение'),
                    value: 2,
                    onChanged: (value) {
                      //Navigator.pop(context, value);
                    },
                  )
                ]),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    //Navigator.of(context).pop(ConfirmAction.CANCEL);
                  },
                ),
                FlatButton(
                  child: const Text('ACCEPT'),
                  onPressed: () {
                    //Navigator.of(context).pop(ConfirmAction.ACCEPT);
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, '/task', arguments: null);

          _showSimpleDialog1();
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

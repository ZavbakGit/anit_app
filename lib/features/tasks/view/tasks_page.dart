import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/tasks/bloc/task_bloc.dart';
import 'package:anit_app/features/tasks/bloc/task_event.dart';
import 'package:anit_app/features/tasks/bloc/task_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<TaskBloc>(context).add(InitialEvent());
          return;
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is InitialState) {
                  BlocProvider.of<TaskBloc>(context).add(InitialEvent());
                  return Text('');
                }

                if (state is ProgressState) {
                  return ProgressWidget();
                }

                //ToDo Надо сделать обновление иеще обновление при ошибке RefreshIndicator работает только с scroll widget


                if (state is ErrorState) {
                  return Text('Error: ${state.errorMessage}');
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

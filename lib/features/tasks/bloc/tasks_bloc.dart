import 'package:anit_app/features/tasks/bloc/tasks_event.dart';
import 'package:anit_app/features/tasks/bloc/tasks_state.dart';
import 'package:anit_app/features/tasks/repository/tasks_repository.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepository _repository;
  final User _user;

  TasksBloc(AppModel appModel)
      : this._repository = TasksRepository(appModel.loginData),
        this._user = appModel.user,
        super(InitialState());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is InitialEvent) {
      try {
        yield ProgressState();
        final listTaskItem = await _repository.getListTaskItem(_user.guid);
        yield ShowListState(listTaskItem);
      } catch (e) {
        yield ErrorState('Error: ${e.toString()}');
      }
    } else {
      throw Exception('Unknown event');
    }
  }
}

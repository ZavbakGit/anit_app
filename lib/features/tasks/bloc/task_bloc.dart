import 'package:anit_app/features/tasks/bloc/task_event.dart';
import 'package:anit_app/features/tasks/bloc/task_state.dart';
import 'package:anit_app/features/tasks/repository/tasks_repository.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TasksRepository _repository;
  final User _user;

  TaskBloc(AppModel appModel)
      : this._repository = TasksRepository(appModel.loginData),
        this._user = appModel.user,
        super(InitialState());


  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
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

import 'package:anit_app/features/task/bloc/task_event.dart';
import 'package:anit_app/features/task/bloc/task_state.dart';
import 'package:anit_app/features/task/model/task.dart';
import 'package:anit_app/features/task/repository/task_repository.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;
  String _guid;

  Task task;

  TaskBloc.newTask(AppModel appModel, this.task)
      : this._repository = TaskRepository(appModel.loginData),
        super(InitialState());

  TaskBloc(AppModel appModel, this._guid)
      : this._repository = TaskRepository(appModel.loginData),
        super(InitialState());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is InitialEvent) {
      try {
        yield ProgressState();
        if (task == null) {
          task = await _repository.getTask(_guid);
        }
        yield ShowTaskState(task);
      } catch (e) {
        yield ErrorState('Error: ${e.toString()}');
      }
    } else {
      throw Exception('Unknown event');
    }
  }
}

import 'package:anit_app/features/task/bloc/task_event.dart';
import 'package:anit_app/features/task/bloc/task_state.dart';
import 'package:anit_app/features/task/model/task.dart';
import 'package:anit_app/features/task/repository/task_repository.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/Catalog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _repository;
  String _guid;
  Task task;
  bool isChanged = false;

  TaskBloc.newTask(AppModel appModel, this.task)
      : this._repository = TaskRepository(appModel.loginData),
        super(InitialState());

  TaskBloc(AppModel appModel, this._guid)
      : this._repository = TaskRepository(appModel.loginData),
        super(InitialState());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    switch (event.runtimeType) {
      case InitialEvent:
        try {
          yield ProgressState();
          if (task == null) {
            task = await _repository.getTask(_guid);
          }
          yield ShowTaskState(task);
        } catch (e) {
          yield ErrorState('Error: ${e.toString()}');
        }
        break;
      case ChangedField:
        final casted = event as ChangedField;
        if (casted == null){
          break;
        }

        switch (casted.fieldKey) {
          case 'partner':
            task = task.copyWith(partner: casted.value);
            yield ShowTaskState(task);
            break;
          case 'responsible':
            task = task.copyWith(responsible: casted.value);
            yield ShowTaskState(task);
            break;
          case 'director':
            task = task.copyWith(director: casted.value);
            yield ShowTaskState(task);
            break;
          case 'groupTask':
            task = task.copyWith(groupTask: casted.value);
            yield ShowTaskState(task);
            break;
          default:
            break;
        }
        isChanged = true;
        break;
      default:
        break;
    }
  }
}

import 'package:anit_app/features/task/model/task.dart';
import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class InitialState extends TaskState {
  @override
  List<Object> get props => [];
}

class ProgressState extends TaskState {
  @override
  List<Object> get props => [];
}

class ShowTaskState extends TaskState {
  final Task task;

  ShowTaskState(this.task);

  @override
  List<Object> get props => [task];
}

class ErrorState extends TaskState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}


import 'package:anit_app/features/tasks/model/tasks.dart';
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

class ShowListState extends TaskState {
  final List<TaskItem> listItem;

  ShowListState(this.listItem);

  @override
  List<Object> get props => [listItem];
}

class ErrorState extends TaskState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

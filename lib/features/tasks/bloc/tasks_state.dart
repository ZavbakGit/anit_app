
import 'package:anit_app/features/tasks/model/tasks.dart';
import 'package:equatable/equatable.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class InitialState extends TasksState {
  @override
  List<Object> get props => [];
}

class ProgressState extends TasksState {
  @override
  List<Object> get props => [];
}

class ShowListState extends TasksState {
  final List<TaskItem> listItem;

  ShowListState(this.listItem);

  @override
  List<Object> get props => [listItem];
}

class ErrorState extends TasksState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

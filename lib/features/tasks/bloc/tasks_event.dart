import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object> get props => [];
}

class InitialEvent extends TasksEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}
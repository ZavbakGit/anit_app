import 'package:anit_app/model/login_data.dart';
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object> get props => [];
}

class InitialEvent extends TaskEvent {
  const InitialEvent();
  @override
  List<Object> get props => [];
}


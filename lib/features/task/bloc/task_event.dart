import 'package:anit_app/features/task/model/task.dart';
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



class ChangedField extends TaskEvent {
  final String fieldKey;
  final dynamic value;

  ChangedField({this.fieldKey, this.value});

  @override
  List<Object> get props => [fieldKey,value];
}


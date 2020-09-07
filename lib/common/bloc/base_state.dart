import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => [];
}

class InitialState extends BaseState {
  @override
  List<Object> get props => [];
}

class ShowProgressState extends BaseState {
  final String text;

  ShowProgressState({this.text});

  @override
  List<Object> get props => [];
}

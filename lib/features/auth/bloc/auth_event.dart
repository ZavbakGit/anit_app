import 'package:anit_app/model/login_data.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class InitialEvent extends AuthEvent {
  const InitialEvent();
  @override
  List<Object> get props => [];
}

class AuthStartEvent extends AuthEvent {
  final LoginData loginData;

  AuthStartEvent(this.loginData);

  @override
  List<Object> get props => [loginData];
}
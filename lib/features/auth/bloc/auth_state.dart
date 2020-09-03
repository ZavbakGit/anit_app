import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';
import 'package:anit_app/model/user_setting.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class ProgressState extends AuthState {
  @override
  List<Object> get props => [];
}


class ShowLoginDataState extends AuthState {
  final LoginData loginData;
  final String errorMessage;

  ShowLoginDataState({this.loginData, this.errorMessage});

  @override
  List<Object> get props => [loginData,errorMessage];
}

class AuthSuccessState extends AuthState {
  final User user;
  final UserSetting userSetting;
  final LoginData loginData;

  AuthSuccessState({@required this.user,@required this.loginData,@required this.userSetting});

  @override
  List<Object> get props => [user,loginData,userSetting];
}



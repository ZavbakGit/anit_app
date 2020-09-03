import 'package:anit_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = AuthRepository();

  AuthBloc() : super(InitialState());

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is InitialEvent) {
      yield ProgressState();
      final loginDataPref = await _repository.getLoginFromSettings();
      yield ShowLoginDataState(loginData: loginDataPref);
    } else if (event is AuthStartEvent) {
      yield ProgressState();
      try {
        await _repository.setLoginFromSettings(event.loginData);

        //await Future.delayed(Duration(milliseconds: 3000));

        final user = await _repository.auth(loginData: event.loginData);
        final userSetting = await _repository.getSetting(
            userGuid: user.guid, loginData: event.loginData);

        yield AuthSuccessState(
          loginData: event.loginData,
          userSetting: userSetting,
          user: user,
        );
      } catch (e) {
        yield ShowLoginDataState(
            loginData: event.loginData, errorMessage: e.toString());
      }
    } else {
      throw Exception('Unknown event');
    }
  }
}

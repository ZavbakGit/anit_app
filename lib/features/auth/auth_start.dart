import 'package:anit_app/features/auth/view/AuthPage.dart';
import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

class AuthStartFeature extends StatelessWidget {

  final Function(User,LoginData) successListener;

  const AuthStartFeature({Key key, this.successListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          if (state is AuthSuccessState){
            successListener(state.user, state.loginData);
          }
        },
        child: AuthPage(),
      ),
    );
  }
}
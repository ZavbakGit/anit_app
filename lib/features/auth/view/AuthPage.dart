import 'package:anit_app/features/auth/bloc/auth_bloc.dart';
import 'package:anit_app/features/auth/bloc/auth_event.dart';
import 'package:anit_app/features/auth/bloc/auth_state.dart';
import 'package:anit_app/model/login_data.dart';
import 'package:anit_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  final Function(User, LoginData) successListener;

  const AuthPage({Key key, this.successListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ShowLoginDataState) {
                if ((state.errorMessage ?? "").isNotEmpty) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (BuildContext context, state) {
                if (state is InitialState) {
                  BlocProvider.of<AuthBloc>(context).add(InitialEvent());
                  return Text('');
                }

                if (state is ProgressState) {
                  return ProgressWidget();
                }

                if (state is ShowLoginDataState) {
                  return _getFormAuth(
                      login: state.loginData.login,
                      password: state.loginData.password,
                      onPressNext: (login, password) {
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthStartEvent(
                            LoginData(login: login, password: password),
                          ),
                        );
                      });
                }

                if (state is AuthSuccessState) {
                  successListener(state.user, state.loginData);
                  return Text('');
                }

                return Text('Unknown state: ${state.toString()}');
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getFormAuth(
    {String login, String password, Function(String, String) onPressNext}) {
  final _passTextFieldController = TextEditingController();
  final _userTextFieldController = TextEditingController();

  _userTextFieldController.text = login;
  _passTextFieldController.text = password;

  return Card(
    semanticContainer: true,
    margin: EdgeInsets.all(24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: _userTextFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter User Here',
                labelText: 'User'),
            autofocus: false,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: _passTextFieldController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password Here',
                labelText: 'Password'),
            autofocus: false,
            obscureText: true,
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  onPressNext(_userTextFieldController.text,
                      _passTextFieldController.text);
                },
              )
            ],
          )
        ],
      ),
    ),
  );
}

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

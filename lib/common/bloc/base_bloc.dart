import 'package:anit_app/model/AppModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(AppModel appModel) : super(InitialState());
}

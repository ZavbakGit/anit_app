import 'package:anit_app/common/bloc/base_state.dart';
import 'package:anit_app/features/searchctalog/model/model.dart';
import 'package:anit_app/features/searchctalog/repository/search_catalog_repository.dart';

class WaitInputState extends BaseState{}

class LoadedState extends BaseState {
  final String message;
  final bool showProgress;
  final bool showResult;
  final ResponseSearch resultSearch;

  LoadedState({
    this.showResult = false,
    this.resultSearch,
    this.message = '',
    this.showProgress = false,
  });

  @override
  List<Object> get props => [message, showProgress];
}
class LoadingErrorState extends BaseState {
  final String message;

  LoadingErrorState({this.message});

  @override
  List<Object> get props => [message];
}



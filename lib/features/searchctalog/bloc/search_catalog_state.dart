import 'package:anit_app/common/bloc/base_state.dart';
import 'package:anit_app/features/searchctalog/model/model.dart';
import 'package:anit_app/features/searchctalog/repository/search_catalog_repository.dart';

class ScreenState extends BaseState {
  final String message;
  final bool showProgress;
  final bool showError;
  final bool showResult;
  final String errorMessage;
  final ResponseSearch resultSearch;

  ScreenState({
    this.showResult = false,
    this.resultSearch,
    this.message = '',
    this.showProgress = false,
    this.showError = false,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [message,showProgress,showError,errorMessage];
}

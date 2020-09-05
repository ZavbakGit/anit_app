import 'package:anit_app/common/bloc/base_event.dart';
import 'package:anit_app/common/bloc/base_state.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_event.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_state.dart';
import 'package:anit_app/features/searchctalog/repository/search_catalog_repository.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchCatalogBloc extends Bloc<BaseEvent, BaseState> {
  final SearchCatalogRepository _repository;

  SearchCatalogBloc(AppModel appModel)
      : this._repository = SearchCatalogRepository(appModel.loginData),
        super(InitialState());

  @override
  Stream<Transition<BaseEvent, BaseState>> transformEvents(
      Stream<BaseEvent> events, next) {
    return events.
    debounceTime(Duration(milliseconds: 500)).switchMap(next);
  }

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is InitialEvent) {
      yield ScreenState();
    } else if (event is ChangedTextEvent) {
      if (event.text.length > 2) {
        yield ScreenState(
          showProgress: true,
          message: 'Идет поиск: ${event.text}',
        );

        final result = await _repository.getListCatalog('Партнеры', event.text);
        print(result.elements.length);
        yield ScreenState(
          showProgress: false,
          message: 'найдено: ${result.size}',
          resultSearch: result,
          showResult: true
        );
      } else {
        yield ScreenState(showProgress: false);
      }
    } else {
      throw Exception('Unknown event');
    }
  }
}

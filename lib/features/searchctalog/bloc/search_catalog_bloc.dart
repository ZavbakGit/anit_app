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

  final String typeCatalog;
  final bool allElements;

  SearchCatalogBloc(
      {AppModel appModel, this.typeCatalog, this.allElements = false})
      : this._repository = SearchCatalogRepository(appModel.loginData),
        super(InitialState());

  @override
  Stream<Transition<BaseEvent, BaseState>> transformEvents(
      Stream<BaseEvent> events, next) {
    return events.debounceTime(Duration(milliseconds: 500)).switchMap(next);
  }

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case InitialEvent:
        if (allElements) {
          yield ShowProgressState();

          try {
            final result = await _repository.getListCatalogAll(typeCatalog);

            yield LoadedState(
                showProgress: false,
                message: 'найдено: ${result.size}',
                resultSearch: result,
                showResult: true);
          } catch (e) {
            yield LoadingErrorState(message: 'Error loading: ${e.toString()}');
          }
        } else {
          yield WaitInputState();
        }
        break;
      case ChangedTextEvent:
        final casted = event as ChangedTextEvent;
        if (casted.text.length <= 2) {
          yield WaitInputState();
          break;
        }

        yield ShowProgressState();

        try {
          final result =
              await _repository.getListCatalog(typeCatalog, casted.text);

          yield LoadedState(
              showProgress: false,
              message: 'найдено: ${result.size}',
              resultSearch: result,
              showResult: true);
        } catch (e) {
          yield LoadingErrorState(message: 'Error loading: ${e.toString()}');
        }
        break;
      default:
        throw Exception('Unknown event');
    }
  }
}

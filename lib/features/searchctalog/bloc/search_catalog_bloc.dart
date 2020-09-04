import 'package:anit_app/features/searchctalog/bloc/search_catalog_event.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_state.dart';

import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCatalogBloc extends Bloc<SearchCatalogEvent, SearchCatalogState> {
  //final TasksRepository _repository;
  final User _user;

  SearchCatalogBloc(AppModel appModel)
     // : this._repository = TasksRepository(appModel.loginData),
      :this._user = appModel.user,
        super(InitialState());

  @override
  Stream<SearchCatalogState> mapEventToState(SearchCatalogEvent event) async* {
    if (event is InitialEvent) {

    } else {
      throw Exception('Unknown event');
    }
  }
}

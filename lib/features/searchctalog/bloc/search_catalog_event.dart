import 'package:equatable/equatable.dart';

abstract class SearchCatalogEvent extends Equatable {
  const SearchCatalogEvent();
  @override
  List<Object> get props => [];
}

class InitialEvent extends SearchCatalogEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}


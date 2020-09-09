import 'package:anit_app/features/searchctalog/view/catalog_page.dart';
import 'package:anit_app/features/searchctalog/view/search_catalog_page.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/search_catalog_bloc.dart';

class SearchCatalogStartFeature extends StatelessWidget {
  final String type;
  final bool allElements;

  const SearchCatalogStartFeature({Key key, this.type, this.allElements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);

    return BlocProvider(
      create: (context) => SearchCatalogBloc(
        appModel: appModel,
        typeCatalog: type,
        allElements: allElements
      ),
      child: allElements?CatalogPage():SearchCatalogPage(),
    );
  }
}

import 'package:anit_app/features/searchctalog/view/search_catalog_page.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/search_catalog_bloc.dart';

class SearchCatalogStartFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);

    RouteSettings settings = ModalRoute.of(context).settings;
    final argument = settings.arguments;

    return BlocProvider(
      create: (context) => SearchCatalogBloc(
        appModel: appModel,
        typeCatalog: argument,
      ),
      child: SearchCatalogPage(),
    );
  }
}

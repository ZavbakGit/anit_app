import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_bloc.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_state.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchCatalogPage extends StatelessWidget {
  final  controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      body: BlocBuilder<SearchCatalogBloc, SearchCatalogState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
            margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  enabled: true,
                  controller: controller,
                  decoration: InputDecoration(
                    //ToDo надо показывать если есть текст
                    suffixIcon: controller.text.length==0?Icon(Icons.clear):null,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Строка поиска',
                  ),
                ),
                Text("Будем искать"),
                SizedBox(
                  height: 24,
                ),
                ProgressWidget()

              ],
            ),
          );
          //return Text('Unknown state: ${state.toString()}');
        },
      ),
    );
  }
}


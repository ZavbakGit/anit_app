import 'package:anit_app/common/bloc/base_event.dart';
import 'package:anit_app/common/bloc/base_state.dart';
import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_bloc.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_event.dart';
import 'package:anit_app/features/searchctalog/bloc/search_catalog_state.dart';
import 'package:anit_app/model/AppModel.dart';
import 'package:anit_app/model/Catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        //margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            //SearchField(),
            Expanded(child: DataContainer()),
          ],
        ),
      ),
    );
  }
}

class DataContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: BlocBuilder<SearchCatalogBloc, BaseState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadedState:
                final casted = state as LoadedState;
                return _loadedData(casted.resultSearch.elements,
                    'всего: ${casted.resultSearch.size}');
                break;
              case ShowProgressState:
                return Center(child: ProgressWidget());
                break;
              case LoadingErrorState:
                final casted = state as LoadingErrorState;
                return Center(child: Text(casted.message));
                break;
              case WaitInputState:
                final casted = state as WaitInputState;
                return Text('Введите не менее 3- букв');
                break;
              case InitialState:
                BlocProvider.of<SearchCatalogBloc>(context).add(InitialEvent());
                return Text('');
                break;
              default:
                return Center(child: ProgressWidget());
            }
          },
        ),
      ),
    );
  }
}

Widget _loadedData(List<Catalog> list, String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        message,
        textAlign: TextAlign.center
      ),
      Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pop(list[index]);
            },
            child: Card(
              child: ListTile(
                title: Text('${list[index].name}'),
                dense: true,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class SearchField extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SearchField> {
  final _controller = TextEditingController();
  bool _showIconClear = true;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      String text = _controller.text ?? "";

      BlocProvider.of<SearchCatalogBloc>(context)
          .add(ChangedTextEvent(text: text));
    });

    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        suffix: IconButton(
          icon: _showIconClear
              ? Icon(Icons.clear)
              : Icon(
                  Icons.clear,
                  size: 0,
                ),
          onPressed: () => _controller.clear(),
        ),
      ),
    );
  }
}

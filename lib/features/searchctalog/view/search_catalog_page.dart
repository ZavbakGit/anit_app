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

class SearchCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            SearchField(),
            InformationText(),
            Expanded(
              child: DataContainer(),
            )
          ],
        ),
      ),
    );
  }
}

class DataContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCatalogBloc, BaseState>(builder: (context, state) {
      if (state is ScreenState) {
        if (state.showProgress) {
          return ProgressWidget();
        } else if (state.showResult) {
          return _list(state.resultSearch.elements);
        } else {
          return Text('');
        }
      } else {
        return Text('');
      }
    });
  }
}

Widget _list(List<Catalog> list) {
  return ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) => GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/task', arguments: list[index].guid);
      },
      child: Card(
        child: ListTile(
          title: Text('${list[index].name}'),
          dense: true,
        ),
      ),
    ),
  );
}

class InformationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCatalogBloc, BaseState>(builder: (context, state) {
      if (state is ScreenState) {
        return Text(state.message);
      } else {
        return Text('');
      }
    });
  }
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
        //labelText: "Search",
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

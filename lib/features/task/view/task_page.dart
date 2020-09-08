import 'package:anit_app/common/view/progress_widget.dart';
import 'package:anit_app/features/task/bloc/task_bloc.dart';
import 'package:anit_app/features/task/bloc/task_event.dart';
import 'package:anit_app/features/task/bloc/task_state.dart';
import 'package:anit_app/features/task/model/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anit_app/common/util/date_utils.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is InitialState) {
              BlocProvider.of<TaskBloc>(context).add(InitialEvent());
              return Text('');
            }

            if (state is ProgressState) {
              return Center(
                child: ProgressWidget(),
              );
            }

            if (state is ErrorState) {
              return ListView(
                children: <Widget>[Text('Error: ${state.errorMessage}')],
              );
            }

            if (state is ShowTaskState) {
              return _showTaskForm(state.task);
            }

            return Text('Unknown state: ${state.toString()}');
          },
        ),
      ),
    );
  }
}

Widget _showTaskForm(Task task) {
  final _partner = TextEditingController();
  _partner.text = task.partner?.name ?? '';

  final _director = TextEditingController();
  _director.text = task.director?.name ?? '';

  final _responsible = TextEditingController();
  _responsible.text = task.responsible?.name ?? '';

  final _groupTask = TextEditingController();
  _groupTask.text = task.groupTask?.name ?? '';

  final _description = TextEditingController();
  _description.text = task.description ?? '';

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text('${task.date.getDateFormatDDMMYY()}'),
              ),
              Expanded(
                flex: 1,
                child: Text('${task.number ?? ''}'),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            enabled: true,
            controller: _description,
            decoration: InputDecoration(
              labelText: 'Описание',
              hintText: 'Описание',
            ),
          ),
          CatalogField(
            text: task.partner?.name ?? '',
            hintText: 'Клиент',
            labelText: 'Клиент',
            typeCatalog: task.partner?.type ?? '',
            fieldKey: 'partner',
          ),
          CatalogField(
            text: task.responsible?.name ?? '',
            hintText: 'Ответственный',
            labelText: 'Ответственный',
            typeCatalog: task.responsible?.type ?? '',
            fieldKey: 'responsible',
          ),
          CatalogField(
            text: task.director?.name ?? '',
            labelText: 'Постановщик',
            hintText: 'Постановщик',
            typeCatalog: task.director?.type ?? '',
            fieldKey: 'director',
          ),
          TextField(
            enabled: false,
            controller: _groupTask,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.keyboard_arrow_right),
              labelText: 'Группа',
              hintText: 'Группа',
            ),
          ),
        ],
      ),
    ),
  );
}

class CatalogField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String text;
  final String typeCatalog;
  final String fieldKey;

  final TextEditingController controller;

  CatalogField(
      {Key key,
      this.labelText,
      this.hintText,
      this.text,
      this.typeCatalog,
      this.fieldKey})
      : this.controller = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = text;

    void _onChoosedCatalog() async {
      final result = await Navigator.pushNamed(context, '/search_catalog',
          arguments: typeCatalog);

      BlocProvider.of<TaskBloc>(context)
            .add(ChangedField(fieldKey: fieldKey, value: result));


    }

    return InkWell(
      onTap: () {
        _onChoosedCatalog();
      },
      child: TextField(
        autofocus: true,
        enabled: false,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.keyboard_arrow_right),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

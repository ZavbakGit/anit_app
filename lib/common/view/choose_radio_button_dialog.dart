import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseRadioButtonDialog extends StatefulWidget {
  final List<String> list;
  final int currentValue;

  const ChooseRadioButtonDialog({Key key, this.list, this.currentValue})
      : super(key: key);

  @override
  _ChooseRadioButtonDialogState createState() =>
      _ChooseRadioButtonDialogState(list: list, currentValue: currentValue);
}

class _ChooseRadioButtonDialogState extends State<ChooseRadioButtonDialog> {
  final List<String> list;
  int currentValue;

  _ChooseRadioButtonDialogState(
      {@required this.list, this.currentValue = 0, Key key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('Сделай выбор'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(list?.length ?? 0, (int index) {
            return RadioListTile(
              //groupValue: (currentValue != null) ? currentValue : 0,
              //selected: (currentValue != null && currentValue == index),
              title: Text(list[index]),
              value: index,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                  Navigator.of(context).pop(currentValue);
                });
                //Navigator.pop(context, value);
              },
            );
          }),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).disabledColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
//          FlatButton(
//              child: Text(
//                'Ok',
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              onPressed: () {
//                Navigator.of(context).pop(currentValue);
//              })
        ],
      ),
    );
  }
}

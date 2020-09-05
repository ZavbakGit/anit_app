import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final String message;

  const ProgressWidget({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircularProgressIndicator(
        ),
        Text(message??"")
      ],
    );
  }
}
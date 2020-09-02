import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'model/AppModel.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = false;
  runApp(MultiProvider(
    providers: [
      Provider<AppModel>.value(value: AppModel())
    ],
    child: App(),
  ));
}


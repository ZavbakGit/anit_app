import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/AppModel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AppModel>.value(value: AppModel())
    ],
    child: App(),
  ));
}


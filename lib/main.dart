import 'package:flojics_assignment/core/injection/injector.dart';
import 'package:flojics_assignment/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

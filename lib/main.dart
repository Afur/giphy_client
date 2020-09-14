import 'package:flutter/material.dart';
import 'package:giphyclient/app.dart';
import 'package:giphyclient/injection/injection.dart';

Future<void> main() async {
  configureInjection();
  runApp(App());
}
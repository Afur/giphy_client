import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:giphyclient/injection/injection.dart';

abstract class BasePage<T extends Cubit> extends StatefulWidget {
  T cubit = getIt<T>();
}
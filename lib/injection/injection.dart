import 'package:get_it/get_it.dart';
import 'package:giphyclient/injection/injection.iconfig.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection() => $initGetIt(getIt);

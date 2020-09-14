// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:giphyclient/api/api_service_factory.dart';
import 'package:giphyclient/database/database_manager.dart';
import 'package:giphyclient/repository/saved_repository.dart';
import 'package:giphyclient/ui/detailed/detailed_cubit.dart';
import 'package:giphyclient/repository/gifs_repository.dart';
import 'package:giphyclient/ui/featured/content_cubit.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ApiServiceFactory>(() => ApiServiceFactory());
  g.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
  g.registerLazySingleton<SavedRepository>(
      () => SavedRepositoryImpl(g<DatabaseProvider>()));
  g.registerFactory<DetailedCubit>(() => DetailedCubit(g<SavedRepository>()));
  g.registerLazySingleton<GifsRepository>(
      () => GifsRepositoryImpl(g<ApiServiceFactory>(), g<SavedRepository>()));
  g.registerFactory<ContentCubit>(() => ContentCubit(g<GifsRepository>()));
}

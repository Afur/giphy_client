import 'dart:async';

import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/database/entities/saved_gif.dart';
import 'package:giphyclient/database/database_manager.dart';
import 'package:injectable/injectable.dart';

abstract class SavedRepository {
  Future<void> save(Gif gif);

  Future<void> unsave(Gif gif);

  Future<bool> isSaved(Gif gif);

  Future<List<Gif>> getAll();
}

@RegisterAs(SavedRepository)
@lazySingleton
class SavedRepositoryImpl extends SavedRepository {
  final DatabaseProvider _databaseProvider;

  SavedRepositoryImpl(this._databaseProvider);

  @override
  Future<void> save(Gif gif) async =>
      await _databaseProvider.database.savedGifsDao
          .insertGif(gif.toDatabaseEntity());

  @override
  Future<void> unsave(Gif gif) async =>
      await _databaseProvider.database.savedGifsDao.removeGif(gif.id);

  @override
  Future<List<Gif>> getAll() async =>
      await _databaseProvider.database.savedGifsDao
          .allSavedGifs()
          .then((saved) => saved.map((it) => it.toDomain()).toList());

  @override
  Future<bool> isSaved(Gif gif) async =>
      await _databaseProvider.database.savedGifsDao.findGifById(gif.id) != null;
}

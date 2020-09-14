import 'dart:async';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:giphyclient/database/daos/saved_gifs_dao.dart';
import 'package:giphyclient/database/entities/saved_gif.dart';

part 'database_manager.g.dart';

@Database(version: 1, entities: [SavedGif])
abstract class DatabaseManager extends FloorDatabase {
  SavedGifsDao get savedGifsDao;
}

@injectable
@lazySingleton
class DatabaseProvider {
  DatabaseManager database;

  DatabaseProvider() {
    build();
  }

  Future<void> build() async {
    database = await $FloorDatabaseManager.databaseBuilder('database.db').build();
  }
}

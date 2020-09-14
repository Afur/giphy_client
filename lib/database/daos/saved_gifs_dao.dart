import 'package:floor/floor.dart';
import 'package:giphyclient/database/entities/saved_gif.dart';

@dao
abstract class SavedGifsDao {
  @Query('SELECT * FROM SavedGif')
  Future<List<SavedGif>> allSavedGifs();

  @Query('SELECT * FROM SavedGif WHERE id = :id')
  Future<SavedGif> findGifById(String id);

  @insert
  Future<void> insertGif(SavedGif person);

  @Query('DELETE FROM SavedGif WHERE id = :id')
  Future<void> removeGif(String id);
}
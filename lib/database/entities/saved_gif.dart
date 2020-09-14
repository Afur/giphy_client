import 'package:floor/floor.dart';
import 'package:giphyclient/api/models/configurations.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/api/models/source.dart';

@entity
class SavedGif {
  @primaryKey
  final String id;
  final String url;
  final String originalUrl;
  final String previewUrl;
  final String previewWidth;
  final String previewHeight;

  SavedGif(this.id, this.url, this.originalUrl, this.previewUrl,
      this.previewWidth, this.previewHeight);
}

extension SavedGifExtensions on SavedGif {
  Gif toDomain() => Gif(
      this.id,
      this.url,
      Configurations(
          original: Source(url: this.originalUrl),
          preview: Source(
              url: this.previewUrl,
              width: this.previewWidth,
              height: this.previewHeight)));
}

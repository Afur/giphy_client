import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/models/configurations.dart';
import 'package:giphyclient/database/entities/saved_gif.dart';

part 'gif.freezed.dart';

part 'gif.g.dart';

@freezed
abstract class Gif with _$Gif {
  factory Gif(
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'url') String url,
    @JsonKey(name: 'images') Configurations configurations,
  ) = _Gif;

  factory Gif.fromJson(Map<String, dynamic> json) => _$GifFromJson(json);
}

extension GifExtensions on Gif {
  SavedGif toDatabaseEntity() => SavedGif(
        this.id,
        this.url,
        this.configurations.original.url,
        this.configurations.preview.url,
        this.configurations.preview.width,
        this.configurations.preview.height,
      );
}

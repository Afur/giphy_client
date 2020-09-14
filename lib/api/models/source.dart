import 'package:freezed_annotation/freezed_annotation.dart';

part 'source.freezed.dart';

part 'source.g.dart';

@freezed
abstract class Source with _$Source {
  factory Source({
    @JsonKey(name: 'height') String height,
    @JsonKey(name: 'width') String width,
    @JsonKey(name: 'size') String size,
    @JsonKey(name: 'url') String url,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) =>
      _$SourceFromJson(json);
}
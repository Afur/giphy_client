import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/api/models/trending/pagination.dart';

part 'trending_response.freezed.dart';

part 'trending_response.g.dart';

@freezed
abstract class GifsResponse with _$GifsResponse {
  factory GifsResponse(
      @JsonKey(name: 'data') List<Gif> gifs,
      @JsonKey(name: 'pagination') Pagination pagination,
      ) = _GifsResponse;

  factory GifsResponse.fromJson(Map<String, dynamic> json) =>
      _$GifsResponseFromJson(json);
}
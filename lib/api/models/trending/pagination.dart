import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

part 'pagination.g.dart';

@freezed
abstract class Pagination with _$Pagination {
  factory Pagination(
      @JsonKey(name: 'total_count') int totalCount,
      @JsonKey(name: 'count') int count,
      @JsonKey(name: 'offset') int offset,
      ) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

extension PaginationExtensions on Pagination {
  int get totalOffset => this.count + this.offset;
}
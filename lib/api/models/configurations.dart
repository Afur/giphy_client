import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/models/source.dart';

part 'configurations.freezed.dart';

part 'configurations.g.dart';

@freezed
abstract class Configurations with _$Configurations {
  factory Configurations({
    @JsonKey(name: 'fixed_height') Source original,
    @JsonKey(name: 'fixed_width_downsampled') Source preview,
  }) = _Configurations;

  factory Configurations.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationsFromJson(json);
}

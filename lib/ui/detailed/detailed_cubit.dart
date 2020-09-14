import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/repository/saved_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:giphyclient/extensions/kotlin_extensions.dart';

part 'detailed_cubit.freezed.dart';

@injectable
class DetailedCubit extends Cubit<DetailedState> {
  final SavedRepository _savedRepository;

  DetailedCubit(this._savedRepository) : super(const DetailedState.loading());

  void checkIfSaved(Gif gif) async {
    emit(DetailedState.loading());
    (await _savedRepository.isSaved(gif))
        .let((it) => emit(DetailedState.loaded(isSaved: it)));
  }

  void save(Gif gif) async {
    await _savedRepository.save(gif);
    emit(DetailedState.loaded(isSaved: true));
  }

  void unsave(Gif gif) async {
    await _savedRepository.unsave(gif);
    emit(DetailedState.loaded(isSaved: false));
  }
}

@freezed
abstract class DetailedState with _$DetailedState {
  const factory DetailedState.loading() = Loading;

  const factory DetailedState.loaded({bool isSaved}) = Loaded;

  const factory DetailedState.error() = Error;
}

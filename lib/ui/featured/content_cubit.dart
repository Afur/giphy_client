import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/repository/gifs_repository.dart';
import 'package:injectable/injectable.dart';

part 'content_cubit.freezed.dart';

@injectable
class ContentCubit extends Cubit<ContentState> {
  final GifsRepository _gifsRepository;

  StreamSubscription _gifsSubscription;

  ContentCubit(this._gifsRepository)
      : super(const ContentState.loading()) {
    _init();
  }

  @override
  Future<void> close() {
    _gifsSubscription.cancel();
    return super.close();
  }

  void _init() {
    _listenForGifsChanges();
  }

  void _listenForGifsChanges() {
    _gifsSubscription = _gifsRepository.gifsStream
        .listen((gifs) => emit(ContentState.loaded(gifs)));
  }

  void fetchFeatured()  {
      emit(ContentState.loading());
      _gifsRepository.fetch(GifsType.trendings());
  }

  void fetchSaved()  {
    emit(ContentState.loading());
    _gifsRepository.fetch(GifsType.saved());
  }

  void refresh() {
    emit(ContentState.loading());
    _gifsRepository.refresh();
  }

  void loadMore()  {
    _gifsRepository.fetchMore();
  }

  void search(String query) {
    _gifsRepository.fetch(GifsType.search(query));
  }
}

@freezed
abstract class ContentState with _$ContentState {
  const factory ContentState.loading() = Loading;

  const factory ContentState.loaded(List<Gif> gifs) = Loaded;

  const factory ContentState.error() = Error;
}

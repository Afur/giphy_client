import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giphyclient/api/api_service.dart';
import 'package:giphyclient/api/api_service_factory.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/api/models/trending/pagination.dart';
import 'package:giphyclient/repository/saved_repository.dart';
import 'package:giphyclient/values/config.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:giphyclient/extensions/kotlin_extensions.dart';

part 'gifs_repository.freezed.dart';

abstract class GifsRepository {
  Stream<List<Gif>> get gifsStream;

  void fetch(GifsType type);

  void fetchMore();

  void refresh();
}

@RegisterAs(GifsRepository)
@lazySingleton
class GifsRepositoryImpl extends GifsRepository {
  final ApiService _apiService;
  final SavedRepository _savedRepository;

  GifsType _currentGifsType;
  List<Gif> _currentGifs;
  Pagination _pagination;

  GifsRepositoryImpl(ApiServiceFactory apiServiceFactory, this._savedRepository)
      : _apiService = apiServiceFactory.get();

  @override
  Stream<List<Gif>> get gifsStream => _gifsSubject.stream;
  final BehaviorSubject<List<Gif>> _gifsSubject = BehaviorSubject();

  @override
  void fetch(GifsType type) {
    _clean();
    _currentGifsType = type;
    _currentGifsType.when(
        trendings: () => _fetchTrendings(),
        search: (query) => _fetchSearchResults(query),
        saved: () => _fetchSaved());
  }

  @override
  void fetchMore() {
    _pagination?.let((it) => _currentGifsType.when(
        trendings: () => _fetchTrendings(offset: it.totalOffset),
        search: (query) => _fetchSearchResults(query, offset: it.totalOffset),
        saved: () => unit));
  }

  @override
  void refresh() {
    fetch(_currentGifsType);
  }

  void _clean() {
    _currentGifs = [];
    _gifsSubject.add([]);
  }

  Future<void> _fetchTrendings({int offset = 0}) async {
    final response = await _apiService.getTrendings(
        Config.GIPHY_API_KEY, offset);
    _currentGifs += response.gifs;
    _pagination = response.pagination;
    _gifsSubject.add(_currentGifs);
    return unit;
  }

  Future<void> _fetchSearchResults(String query, {int offset = 0}) async {
    final response = await _apiService.getSearchResult(
        Config.GIPHY_API_KEY, query, offset);
    _currentGifs += response.gifs;
    _pagination = response.pagination;
    _gifsSubject.add(_currentGifs);
    return unit;
  }

  Future<void> _fetchSaved() async {
    final gifs = await _savedRepository.getAll();
    _currentGifs += gifs;
    _gifsSubject.add(_currentGifs);
    return unit;
  }
}

@freezed
abstract class GifsType with _$GifsType {
  const factory GifsType.trendings() = Trendings;

  const factory GifsType.search(String query) = Search;

  const factory GifsType.saved() = Favorites;
}

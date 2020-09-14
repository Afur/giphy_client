import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/repository/gifs_repository.dart';
import 'package:giphyclient/ui/content/content_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../mocks/mocks.dart';

void main() {
  GifsRepository _gifsRepository;

  BehaviorSubject<List<Gif>> _gifsSubject;
  List<Gif> _gifs = [Gif(), Gif()];

  setUp(() {
    _gifsSubject = BehaviorSubject();
    _gifsRepository = MockGifsRepository();
    when(_gifsRepository.gifsStream)
        .thenAnswer((_) => _gifsSubject.stream);
  });

  tearDown(() {
    _gifsSubject.close();
  });

  blocTest<ContentCubit, ContentState>(
    "emits list of trendings gifs",
    build: () {
      when(_gifsRepository.fetch(GifsType.featured()))
          .thenAnswer((_) => Future.value(_gifs));
      return ContentCubit(_gifsRepository);
    },
    act: (cubit) {
      _gifsSubject.add(_gifs);
      cubit.fetchFeatured();
    },
    verify: (cubit) {
      verify(_gifsRepository.fetch(GifsType.featured()));
    },
    expect: [ContentState.loading(), ContentState.loaded(_gifs)],
  );

  blocTest<ContentCubit, ContentState>(
    "emits list of saved gifs",
    build: () {
      when(_gifsRepository.fetch(GifsType.saved()))
          .thenAnswer((_) => Future.value(_gifs));
      return ContentCubit(_gifsRepository);
    },
    act: (cubit) {
      _gifsSubject.add(_gifs);
      cubit.fetchSaved();
    },
    verify: (cubit) {
      verify(_gifsRepository.fetch(GifsType.saved()));
    },
    expect: [ContentState.loading(), ContentState.loaded(_gifs)],
  );
}
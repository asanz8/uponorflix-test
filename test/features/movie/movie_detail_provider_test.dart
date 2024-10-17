import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_detail_provider.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

import '../../util/create_container.dart';

class MockGetMovieByIdUsecase extends Mock implements GetMovieByIdUsecase {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  final sl = GetIt.instance;
  group('MovieDetailNotifier tests', () {
    late ProviderContainer container;
    late MockGetMovieByIdUsecase mockGetMovieByIdUsecase;

    setUpAll(() {
      registerFallbackValue(const Movie());
    });

    setUp(() async {
      container = createContainer();
      mockGetMovieByIdUsecase = MockGetMovieByIdUsecase();

      // await sl.reset();

      sl.registerLazySingleton<GetMovieByIdUsecase>(
          () => mockGetMovieByIdUsecase);
    });

    tearDown(() async {
      container.dispose();
      await sl.reset();
    });

    test('Initial state should be a null Movie', () {
      final movie = container.read(movieDetailNotifierProvider);
      expect(movie, equals(null));
    });

    test('Should get a movie by ID correctly', () async {
      final movieDetailNotifier =
          container.read(movieDetailNotifierProvider.notifier);

      const movieReturned = Movie(
        id: 1,
        title: 'Title',
        description: 'Description',
        duration: 120,
        imageUrl: 'https://image.com',
        director: 'Director',
        releaseDate: '2022-01-01',
        rating: 4.5,
      );

      when(() => mockGetMovieByIdUsecase(1))
          .thenAnswer((_) async => const Right(movieReturned));

      await movieDetailNotifier.getMovieById(1);

      final movieState = container.read(movieDetailNotifierProvider);

      expect(movieState, equals(movieReturned));
    });

    test(
        'getMovieByIdState should emit [Loading, Loaded] when get a movie correctly',
        () async {
      final movieDetailNotifier =
          container.read(movieDetailNotifierProvider.notifier);

      const movieReturned = Movie(
        id: 1,
        title: 'Title',
        description: 'Description',
        duration: 120,
        imageUrl: 'https://image.com',
        director: 'Director',
        releaseDate: '2022-01-01',
        rating: 4.5,
      );

      when(() => mockGetMovieByIdUsecase(1))
          .thenAnswer((_) async => const Right(movieReturned));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        getMovieByIdState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(getMovieByIdState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Loaded>(),
          ]));

      await movieDetailNotifier.getMovieById(1);
    });

    test(
        'getMovieByIdState should emit [Loading, Error] when get a movie failed',
        () async {
      final movieDetailNotifier =
          container.read(movieDetailNotifierProvider.notifier);

      when(() => mockGetMovieByIdUsecase(1))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        getMovieByIdState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(getMovieByIdState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Error>(),
          ]));

      await movieDetailNotifier.getMovieById(1);
    });

    test('Should refresh a movie correctly', () async {
      final movieDetailNotifier =
          container.read(movieDetailNotifierProvider.notifier);

      const movieReturned = Movie(
        id: 1,
        title: 'Title',
        description: 'Description',
        duration: 120,
        imageUrl: 'https://image.com',
        director: 'Director',
        releaseDate: '2022-01-01',
        rating: 4.5,
      );

      const movieUpdated = Movie(
        id: 1,
        title: 'Title Updated',
        description: 'Description',
        duration: 120,
        imageUrl: 'https://image.com',
        director: 'Director',
        releaseDate: '2022-01-01',
        rating: 4.5,
      );

      movieDetailNotifier.state = movieReturned;

      await movieDetailNotifier.refreshMovie(movieUpdated);

      final movieState = container.read(movieDetailNotifierProvider);

      expect(movieState, equals(movieUpdated));
    });
  });
}

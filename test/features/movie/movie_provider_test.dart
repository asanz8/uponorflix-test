import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';
import 'package:uponorflix/features/movie/domain/usecases/add_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movies_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/update_movie_usecase.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

import '../../util/create_container.dart';

class MockGetMoviesUsecase extends Mock implements GetMoviesUsecase {}

class MockAddMovieUsecase extends Mock implements AddMovieUsecase {}

class MockDeleteMovieUsecase extends Mock implements DeleteMovieUsecase {}

class MockUpdateMovieUsecase extends Mock implements UpdateMovieUsecase {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  final sl = GetIt.instance;
  group('MovieNotifier tests', () {
    late ProviderContainer container;
    late MockGetMoviesUsecase mockGetMoviesUsecase;
    late MockAddMovieUsecase mockAddMovieUsecase;
    late MockDeleteMovieUsecase mockDeleteMovieUsecase;
    late MockUpdateMovieUsecase mockUpdateMovieUsecase;

    setUpAll(() {
      registerFallbackValue(const Movie());
      registerFallbackValue(
          MoviesResponse(totalCount: 1, movies: [const Movie()]));
      registerFallbackValue(GetMoviesUsecaseParams(offset: 0, limit: 20));
    });

    setUp(() {
      container = createContainer();
      mockGetMoviesUsecase = MockGetMoviesUsecase();
      mockAddMovieUsecase = MockAddMovieUsecase();
      mockDeleteMovieUsecase = MockDeleteMovieUsecase();
      mockUpdateMovieUsecase = MockUpdateMovieUsecase();

      // sl.reset();

      sl.registerLazySingleton<GetMoviesUsecase>(() => mockGetMoviesUsecase);
      sl.registerLazySingleton<AddMovieUsecase>(() => mockAddMovieUsecase);
      sl.registerLazySingleton<DeleteMovieUsecase>(
          () => mockDeleteMovieUsecase);
      sl.registerLazySingleton<UpdateMovieUsecase>(
          () => mockUpdateMovieUsecase);
    });

    tearDown(() async {
      container.dispose();
      await sl.reset();
    });

    test('Initial state should be an empty list of movies', () {
      final movieList = container.read(movieNotifierProvider);
      expect(movieList, equals([]));
    });

    test('Should add one movie correctly', () async {
      const testMovie = Movie(title: 'Test movie');
      final movieNotifier = container.read(movieNotifierProvider.notifier);

      when(() => mockAddMovieUsecase(any()))
          .thenAnswer((_) async => const Right(testMovie));

      when(() => mockGetMoviesUsecase(any())).thenAnswer((_) async =>
          Right(MoviesResponse(totalCount: 1, movies: [testMovie])));

      await movieNotifier.addMovie(testMovie);

      final movieList = container.read(movieNotifierProvider);

      expect(movieList.length, equals(1));
    });

    test('addMovieState should emit [Loading, Loaded] when add movie correctly',
        () async {
      final testMovie = Movie(title: 'Test movie');
      final movieNotifier = container.read(movieNotifierProvider.notifier);

      when(() => mockAddMovieUsecase(any()))
          .thenAnswer((_) async => Right(testMovie));

      when(() => mockGetMoviesUsecase(any())).thenAnswer((_) async =>
          Right(MoviesResponse(totalCount: 1, movies: [testMovie])));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        addMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(addMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Loaded>(),
          ]));

      await movieNotifier.addMovie(testMovie);
    });

    test('addMovieState should emit [Loading, Error] when add movie failed',
        () async {
      final testMovie = Movie(title: 'Test movie');
      final movieNotifier = container.read(movieNotifierProvider.notifier);

      when(() => mockAddMovieUsecase(any()))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        addMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(addMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Error>(),
          ]));

      await movieNotifier.addMovie(testMovie);
    });

    test('Should delete one movie correctly', () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockDeleteMovieUsecase(any()))
          .thenAnswer((_) async => Right(testMovie.id!));

      await notifier.deleteMovie(testMovie);

      final movieList = container.read(movieNotifierProvider);

      expect(movieList.length, equals(0));
    });

    test(
        'deleteMovieState should emit [Loading, Loaded] when delete movie correctly',
        () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockDeleteMovieUsecase(any()))
          .thenAnswer((_) async => Right(testMovie.id!));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        deleteMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(deleteMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Loaded>(),
          ]));

      await notifier.deleteMovie(testMovie);
    });

    test(
        'deleteMovieState should emit [Loading, Error] when delete movie failed',
        () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockDeleteMovieUsecase(any()))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        deleteMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(deleteMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Error>(),
          ]));

      await notifier.deleteMovie(testMovie);

      final movieList = container.read(movieNotifierProvider);

      expect(movieList.length, equals(1));
    });

    test('Should update a movie correctly', () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final testMovieUpd = Movie(id: 1, title: 'Test movie updated');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockUpdateMovieUsecase(any()))
          .thenAnswer((_) async => Right(testMovieUpd));

      await notifier.updateMovie(testMovieUpd);

      final movieList = container.read(movieNotifierProvider);

      expect(movieList.first.title, equals('Test movie updated'));
    });

    test(
        'updateMovieState should emit [Loading, Loaded] when update movie correctly',
        () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final testMovieUpd = Movie(id: 1, title: 'Test movie updated');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockUpdateMovieUsecase(any()))
          .thenAnswer((_) async => Right(testMovieUpd));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        updateMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(updateMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Loaded>(),
          ]));

      await notifier.updateMovie(testMovieUpd);
    });

    test(
        'updateMovieState should emit [Loading, Error] when update movie failed',
        () async {
      final testMovie = Movie(id: 1, title: 'Test movie');
      final testMovieUpd = Movie(id: 1, title: 'Test movie updated');
      final notifier = container.read(movieNotifierProvider.notifier);

      notifier.state = [testMovie];

      when(() => mockUpdateMovieUsecase(any()))
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final listener = Listener<BaseState>();

      container.listen<BaseState>(
        updateMovieState,
        listener.call,
        fireImmediately: true,
      );

      expectLater(
          container.read(updateMovieState.notifier).stream,
          emitsInOrder([
            isA<Loading>(),
            isA<Error>(),
          ]));

      await notifier.updateMovie(testMovieUpd);
    });
  });
}

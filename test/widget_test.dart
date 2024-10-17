import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uponorflix/app.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';
import 'package:uponorflix/features/movie/domain/usecases/add_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movies_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/update_movie_usecase.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_add_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_catalog_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_detail_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_update_page.dart';
import 'package:uponorflix/features/movie/presentation/widget/movie_item.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/router/generate_router.dart';

class MockGetMoviesUsecase extends Mock implements GetMoviesUsecase {}

class MockAddMovieUsecase extends Mock implements AddMovieUsecase {}

class MockDeleteMovieUsecase extends Mock implements DeleteMovieUsecase {}

class MockUpdateMovieUsecase extends Mock implements UpdateMovieUsecase {}

class MockGetMovieByIdUsecase extends Mock implements GetMovieByIdUsecase {}

void main() {
  final sl = GetIt.instance;

  group('MovieCatalogPage tests', () {
    late GoRouter testRouter;
    late MockGetMoviesUsecase mockGetMoviesUsecase;
    late MockAddMovieUsecase mockAddMovieUsecase;
    late MockDeleteMovieUsecase mockDeleteMovieUsecase;
    late MockUpdateMovieUsecase mockUpdateMovieUsecase;
    late MockGetMovieByIdUsecase mockGetMovieByIdUsecase;

    const movie = Movie(
      id: 1,
      title: 'Title',
      description: 'Description',
      duration: 120,
      imageUrl: 'https://image.com',
      director: 'Director',
      releaseDate: '2022-01-01',
      rating: 4.5,
    );

    setUpAll(() {
      registerFallbackValue(const Movie());
      registerFallbackValue(MoviesResponse(totalCount: 0, movies: []));
      registerFallbackValue(GetMoviesUsecaseParams(offset: 0, limit: 20));
    });

    setUp(() async {
      mockGetMoviesUsecase = MockGetMoviesUsecase();
      mockAddMovieUsecase = MockAddMovieUsecase();
      mockDeleteMovieUsecase = MockDeleteMovieUsecase();
      mockUpdateMovieUsecase = MockUpdateMovieUsecase();
      mockGetMovieByIdUsecase = MockGetMovieByIdUsecase();

      sl.registerLazySingleton<GetMoviesUsecase>(() => mockGetMoviesUsecase);
      sl.registerLazySingleton<AddMovieUsecase>(() => mockAddMovieUsecase);
      sl.registerLazySingleton<DeleteMovieUsecase>(
          () => mockDeleteMovieUsecase);
      sl.registerLazySingleton<UpdateMovieUsecase>(
          () => mockUpdateMovieUsecase);
      sl.registerLazySingleton<GetMovieByIdUsecase>(
          () => mockGetMovieByIdUsecase);

      testRouter = generateRouter();
    });

    tearDown(() async {
      await sl.reset();
    });

    testWidgets('MovieCatalogPage renders empty', (WidgetTester tester) async {
      when(() => mockGetMoviesUsecase(any())).thenAnswer(
          (_) async => Right(MoviesResponse(totalCount: 0, movies: [])));

      await tester.pumpWidget(ProviderScope(
          child: App(
        testRouter: testRouter,
      )));

      final localizedText =
          S.of(tester.element(find.byType(MovieCatalogPage))).movieCatalog;

      expect(find.text(localizedText), findsOneWidget);
    });

    testWidgets('MovieCatalogPage renders with movies',
        (WidgetTester tester) async {
      when(() => mockGetMoviesUsecase(any())).thenAnswer((_) async =>
          Right(MoviesResponse(totalCount: 1, movies: [const Movie()])));

      await tester.pumpWidget(ProviderScope(
          child: App(
        testRouter: testRouter,
      )));

      await tester.pump();

      expect(find.byType(MovieItem), findsOneWidget);
    });

    testWidgets('Navigate to MovieAddPage', (WidgetTester tester) async {
      when(() => mockGetMoviesUsecase(any())).thenAnswer((_) async =>
          Right(MoviesResponse(totalCount: 1, movies: [const Movie()])));

      await tester.pumpWidget(ProviderScope(
          child: App(
        testRouter: testRouter,
      )));

      await tester.pumpAndSettle();

      final addMovieButton = find.byKey(const Key('add_movie_button'));

      expect(addMovieButton, findsOneWidget);

      await tester.tap(addMovieButton);

      await tester.pumpAndSettle();

      expect(find.byType(MovieCatalogPage), findsNothing);
      expect(find.byType(MovieAddPage), findsOneWidget);

      final localizedText =
          S.of(tester.element(find.byType(MovieAddPage))).addMovie;

      expect(find.text(localizedText), findsOneWidget);
    });

    testWidgets('Navigate to MovieDetailPage', (WidgetTester tester) async {
      const mmovie = Movie(
        id: 1,
        title: 'Title',
        description: 'Description',
        duration: 120,
        imageUrl: 'https://image.com',
        director: 'Director',
        releaseDate: '2022-01-01',
        rating: 4.5,
      );
      when(() => mockGetMoviesUsecase(any())).thenAnswer(
          (_) async => Right(MoviesResponse(totalCount: 1, movies: [mmovie])));

      when(() => mockGetMovieByIdUsecase(1))
          .thenAnswer((_) async => const Right(movie));

      await tester.pumpWidget(ProviderScope(
          child: App(
        testRouter: testRouter,
      )));

      await tester.pumpAndSettle();

      final movieItem = find.byKey(const Key('movie_item_1'));

      expect(movieItem, findsOneWidget);

      await tester.tap(movieItem);

      await tester.pumpAndSettle();

      expect(find.byType(MovieCatalogPage), findsNothing);
      expect(find.byType(MovieDetailPage), findsOneWidget);

      final localizedText =
          S.of(tester.element(find.byType(MovieDetailPage))).movieDetails;

      expect(find.text(localizedText), findsOneWidget);
      expect(find.text(movie.title!), findsOneWidget);
    });

    testWidgets('Navigate to MovieUpdatePage', (WidgetTester tester) async {
      when(() => mockGetMoviesUsecase(any())).thenAnswer(
          (_) async => Right(MoviesResponse(totalCount: 1, movies: [movie])));

      when(() => mockGetMovieByIdUsecase(1))
          .thenAnswer((_) async => const Right(movie));

      await tester.pumpWidget(ProviderScope(
          child: App(
        testRouter: testRouter,
      )));

      await tester.pumpAndSettle();

      final movieItem = find.byKey(const Key('movie_item_1'));

      await tester.tap(movieItem);

      await tester.pumpAndSettle();

      final editMovieButton = find.byKey(const Key('edit_movie_button'));

      await tester.tap(editMovieButton);

      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailPage), findsNothing);
      expect(find.byType(MovieUpdatePage), findsOneWidget);

      final localizedText =
          S.of(tester.element(find.byType(MovieUpdatePage))).updateMovie;

      expect(find.text(localizedText), findsOneWidget);
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uponorflix/di/injection_container.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/usecases/add_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movies_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/update_movie_usecase.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

final movieNotifierProvider =
    NotifierProvider<MovieNotifier, List<Movie>>(MovieNotifier.new);

final getMoviesState = StateProvider<BaseState>((ref) => Initial());
final addMovieState = StateProvider<BaseState>((ref) => Initial());
final deleteMovieState = StateProvider<BaseState>((ref) => Initial());
final updateMovieState = StateProvider<BaseState>((ref) => Initial());

class MovieNotifier extends Notifier<List<Movie>> {
  final GetMoviesUsecase _getMoviesUsecase = sl<GetMoviesUsecase>();
  final AddMovieUsecase _addMovieUsecase = sl<AddMovieUsecase>();
  final DeleteMovieUsecase _deleteMovieUsecase = sl<DeleteMovieUsecase>();
  final UpdateMovieUsecase _updateMovieUsecase = sl<UpdateMovieUsecase>();

  int _page = 0;
  int _limit = 20;
  int totalCount = 0;

  @override
  List<Movie> build() {
    return [];
  }

  void loadMore() {
    getMovies(page: _page + 1, silent: true);
  }

  Future<void> getMovies({
    int? page = 0,
    int? limit,
    bool silent = false,
  }) async {
    _page = page ?? _page;
    _limit = limit ?? _limit;

    if (!silent) {
      ref.read(getMoviesState.notifier).state = Loading();
    }

    final moviesOrFailure = await _getMoviesUsecase(
        GetMoviesUsecaseParams(offset: _page * _limit, limit: _limit));
    return moviesOrFailure.fold((failure) {
      ref.read(getMoviesState.notifier).state = Error(failure);
    }, (moviesRes) {
      if (page == 0) {
        state = moviesRes.movies;
      } else {
        state = [...state, ...moviesRes.movies];
      }
      totalCount = moviesRes.totalCount;

      ref.read(getMoviesState.notifier).state = Loaded();
    });
  }

  Future<void> addMovie(Movie movie) async {
    ref.read(addMovieState.notifier).state = Loading();

    final movieOrFailure = await _addMovieUsecase(movie);

    return movieOrFailure.fold((failure) {
      ref.read(addMovieState.notifier).state = Error(failure);
    }, (movie) async {
      await getMovies(limit: 20, page: 0);
      ref.read(addMovieState.notifier).state = Loaded(data: movie);
    });
  }

  Future<void> deleteMovie(Movie movie) async {
    ref.read(deleteMovieState.notifier).state = Loading();

    final deleteOrFailure = await _deleteMovieUsecase(movie);

    return deleteOrFailure.fold((failure) {
      ref.read(deleteMovieState.notifier).state = Error(failure);
    }, (movieId) {
      Movie movieDeleted = const Movie(title: 'Unknown');

      state = state.where((movie) {
        if (movie.id == movieId) {
          movieDeleted = movie;
        }
        return movie.id != movieId;
      }).toList();
      ref.read(deleteMovieState.notifier).state = Loaded(data: movieDeleted);
    });
  }

  Future<void> updateMovie(Movie movie) async {
    ref.read(updateMovieState.notifier).state = Loading();

    final movieOrFailure = await _updateMovieUsecase(movie);

    return movieOrFailure.fold((failure) {
      ref.read(updateMovieState.notifier).state = Error(failure);
    }, (movie) {
      state = state.map((m) {
        if (m.id == movie.id) {
          return movie;
        }
        return m;
      }).toList();
      ref.read(updateMovieState.notifier).state = Loaded(data: movie);
    });
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uponorflix/di/injection_container.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

final movieDetailNotifierProvider =
    NotifierProvider.autoDispose<MovieDetailNotifier, Movie?>(
        MovieDetailNotifier.new);

final getMovieByIdState =
    StateProvider.autoDispose<BaseState>((ref) => Initial());

class MovieDetailNotifier extends AutoDisposeNotifier<Movie?> {
  final GetMovieByIdUsecase _getMovieByIdUsecase = sl<GetMovieByIdUsecase>();

  @override
  Movie? build() {
    return null;
  }

  Future<void> getMovieById(int movieId) async {
    ref.read(getMovieByIdState.notifier).state = Loading();

    final movieOrFailure = await _getMovieByIdUsecase(movieId);

    return movieOrFailure.fold((failure) {
      ref.read(getMovieByIdState.notifier).state = Error(failure);
    }, (movie) async {
      state = movie;

      ref.read(getMovieByIdState.notifier).state = Loaded();
    });
  }

  Future<void> refreshMovie(Movie movie) async {
    if (state != null && state?.id == movie.id) {
      state = movie;
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';

abstract class MovieRepository {
  Future<Either<Failure, Movie>> addMovie(Movie movie);

  Future<Either<Failure, Movie?>> getMovieById({required int movieId});

  Future<Either<Failure, int>> deleteMovie(Movie movie);

  Future<Either<Failure, Movie>> updateMovie(Movie movie);

  Future<Either<Failure, MoviesResponse>> getMovies({
    required int offset,
    required int limit,
  });
}

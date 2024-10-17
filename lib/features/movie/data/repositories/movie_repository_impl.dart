import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/features/movie/data/datasources/local/movie_local_data_source.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieLocalDataSource movieLocalDataSource;

  MovieRepositoryImpl({required this.movieLocalDataSource});

  @override
  Future<Either<Failure, Movie>> addMovie(Movie movie) async {
    try {
      final newMovie = await movieLocalDataSource.addMovie(movie);
      return Right(newMovie);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteMovie(Movie movie) async {
    try {
      final isDeleted = await movieLocalDataSource.deleteMovie(movie);

      if (isDeleted != 1) {
        return Left(UnexpectedFailure());
      }

      return Right(movie.id!);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Movie?>> getMovieById({required int movieId}) async {
    try {
      final movie = await movieLocalDataSource.getMovieById(movieId);
      return Right(movie);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, MoviesResponse>> getMovies(
      {required int offset, required int limit}) async {
    try {
      final movies =
          await movieLocalDataSource.getMovies(offset: offset, limit: limit);
      return Right(movies);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> updateMovie(Movie movie) async {
    try {
      final updatedMovie = await movieLocalDataSource.updateMovie(movie);
      return Right(updatedMovie);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}

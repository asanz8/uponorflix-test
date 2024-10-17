import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/core/usecase/usecase.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

class DeleteMovieUsecase extends UseCase<int, Movie> {
  final MovieRepository movieRepository;

  DeleteMovieUsecase({required this.movieRepository});

  @override
  Future<Either<Failure, int>> call(Movie params, {Callback? callback}) {
    return movieRepository.deleteMovie(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/core/usecase/usecase.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

class GetMovieByIdUsecase extends UseCase<Movie?, int> {
  final MovieRepository movieRepository;

  GetMovieByIdUsecase({required this.movieRepository});

  @override
  Future<Either<Failure, Movie?>> call(int params, {Callback? callback}) {
    return movieRepository.getMovieById(movieId: params);
  }
}

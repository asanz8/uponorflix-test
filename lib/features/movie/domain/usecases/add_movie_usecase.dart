import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/core/usecase/usecase.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

class AddMovieUsecase extends UseCase<Movie, Movie> {
  final MovieRepository movieRepository;

  AddMovieUsecase({required this.movieRepository});

  @override
  Future<Either<Failure, Movie>> call(Movie params, {Callback? callback}) {
    return movieRepository.addMovie(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:uponorflix/core/errors/failure.dart';
import 'package:uponorflix/core/usecase/usecase.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

class GetMoviesUsecase extends UseCase<MoviesResponse, GetMoviesUsecaseParams> {
  final MovieRepository movieRepository;

  GetMoviesUsecase({required this.movieRepository});

  @override
  Future<Either<Failure, MoviesResponse>> call(GetMoviesUsecaseParams params,
      {Callback? callback}) {
    return movieRepository.getMovies(
      offset: params.offset,
      limit: params.limit,
    );
  }
}

class GetMoviesUsecaseParams {
  final int offset;
  final int limit;

  GetMoviesUsecaseParams({required this.offset, required this.limit});
}

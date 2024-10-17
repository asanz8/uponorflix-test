import 'package:get_it/get_it.dart';
import 'package:uponorflix/features/movie/domain/usecases/add_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/delete_movie_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/get_movies_usecase.dart';
import 'package:uponorflix/features/movie/domain/usecases/update_movie_usecase.dart';

void initUseCase(GetIt sl) {
  sl.registerLazySingleton(
    () => AddMovieUsecase(
      movieRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetMoviesUsecase>(
    () => GetMoviesUsecase(
      movieRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeleteMovieUsecase(
      movieRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateMovieUsecase(
      movieRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetMovieByIdUsecase(
      movieRepository: sl(),
    ),
  );
}

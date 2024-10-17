import 'package:get_it/get_it.dart';
import 'package:uponorflix/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:uponorflix/features/movie/domain/repositories/movie_repository.dart';

void initRepository(GetIt sl) {
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieLocalDataSource: sl(),
    ),
  );
}

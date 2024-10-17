import 'package:get_it/get_it.dart';
import 'package:uponorflix/features/movie/data/datasources/local/movie_local_data_source.dart';

void initDataSource(GetIt sl) {
  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      appDatabase: sl(),
    ),
  );
}

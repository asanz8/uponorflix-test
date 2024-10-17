import 'package:get_it/get_it.dart';
import 'package:uponorflix/features/movie/di/data_source_module.dart';
import 'package:uponorflix/features/movie/di/repository_module.dart';
import 'package:uponorflix/features/movie/di/usecase_module.dart';

void initMovieModule(GetIt sl) {
  initDataSource(sl);
  initRepository(sl);
  initUseCase(sl);
}

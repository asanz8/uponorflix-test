import 'package:get_it/get_it.dart';
import 'package:uponorflix/di/external_module.dart';
import 'package:uponorflix/features/movie/di/movie_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initExternalModule(sl);

  // Features
  initMovieModule(sl);
}

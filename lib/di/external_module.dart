import 'package:get_it/get_it.dart';
import 'package:uponorflix/core/database/app_database.dart';

Future<void> initExternalModule(GetIt sl) async {
  final database = await LocalDb.getInstance();

  sl.registerLazySingleton(() => database);
}

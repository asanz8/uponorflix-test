import 'dart:async';
import 'package:floor/floor.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:uponorflix/features/movie/domain/entities/movie_dao.dart';

part 'app_database.g.dart';

class LocalDb {
  LocalDb._();

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    _instance ??= await $FloorAppDatabase
        .databaseBuilder("uponorflix_database.db")
        .build();

    return _instance!;
  }
}

@Database(version: 1, entities: [Movie])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}

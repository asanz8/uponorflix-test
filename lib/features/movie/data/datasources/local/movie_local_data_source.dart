import 'package:uponorflix/core/database/app_database.dart';
import 'package:uponorflix/features/movie/data/models/movie_model.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/domain/entities/movies_response.dart';

abstract class MovieLocalDataSource {
  Future<MovieModel> addMovie(Movie movie);

  Future<MovieModel?> getMovieById(int movieId);

  Future<int> deleteMovie(Movie movie);

  Future<MovieModel> updateMovie(Movie movie);

  Future<MoviesResponse> getMovies({
    required int offset,
    required int limit,
  });
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final AppDatabase appDatabase;

  MovieLocalDataSourceImpl({required this.appDatabase});

  @override
  Future<MovieModel> addMovie(Movie movie) async {
    final id = await appDatabase.movieDao.insertMovie(movie);
    final movieModel = MovieModel.fromEntity(movie).copyWith(id: id);

    return movieModel;
  }

  @override
  Future<int> deleteMovie(Movie movie) async {
    return await appDatabase.movieDao.deleteMovie(movie);
  }

  @override
  Future<MovieModel?> getMovieById(int movieId) async {
    final movie = await appDatabase.movieDao.getMovieById(movieId);

    return movie != null ? MovieModel.fromEntity(movie) : null;
  }

  @override
  Future<MoviesResponse> getMovies(
      {required int offset, required int limit}) async {
    final response = await appDatabase.movieDao.getMovies(offset, limit);
    final totalCount = await appDatabase.movieDao.getMoviesCount() ?? 0;

    final movies =
        response.map((movie) => MovieModel.fromEntity(movie)).toList();

    return MoviesResponse(totalCount: totalCount, movies: movies);
  }

  @override
  Future<MovieModel> updateMovie(Movie movie) async {
    await appDatabase.movieDao.updateMovie(movie);

    return MovieModel.fromEntity(movie);
  }
}

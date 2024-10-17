import 'package:floor/floor.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT id, title, imageUrl FROM Movie LIMIT :limit OFFSET :offset')
  Future<List<Movie>> getMovies(int offset, int limit);

  @Query('SELECT COUNT(id) FROM Movie')
  Future<int?> getMoviesCount();

  @Query('SELECT * FROM Movie WHERE id = :id')
  Future<Movie?> getMovieById(int id);

  @insert
  Future<int> insertMovie(Movie movie);

  @update
  Future<int> updateMovie(Movie movie);

  @delete
  Future<int> deleteMovie(Movie movie);
}

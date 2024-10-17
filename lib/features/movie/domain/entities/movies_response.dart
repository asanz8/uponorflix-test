import 'package:uponorflix/features/movie/domain/entities/movie.dart';

class MoviesResponse {
  final int totalCount;
  final List<Movie> movies;

  MoviesResponse({required this.totalCount, required this.movies});
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';

part 'movie_model.freezed.dart';

@freezed
class MovieModel extends Movie with _$MovieModel {
  MovieModel._();

  factory MovieModel({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    String? director,
    String? releaseDate,
    int? duration,
    double? rating,
  }) = _MovieModel;

  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      description: movie.description,
      imageUrl: movie.imageUrl,
      director: movie.director,
      releaseDate: movie.releaseDate,
      duration: movie.duration,
      rating: movie.rating,
    );
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      director: director,
      releaseDate: releaseDate,
      duration: duration,
      rating: rating,
    );
  }
}

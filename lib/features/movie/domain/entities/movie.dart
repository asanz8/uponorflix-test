import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Movie extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? title;
  final String? description;
  final int? duration;
  final String? imageUrl;
  final String? director;
  final String? releaseDate;
  final double? rating;

  const Movie({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.imageUrl,
    this.director,
    this.releaseDate,
    this.rating,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        duration,
        imageUrl,
        director,
        releaseDate,
        rating
      ];
}

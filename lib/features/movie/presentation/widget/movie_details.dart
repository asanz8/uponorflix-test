import 'package:flutter/material.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

class MovieDetails extends StatelessWidget {
  final Movie? movie;
  final BaseState currentState;

  const MovieDetails({super.key, this.movie, required this.currentState});

  @override
  Widget build(BuildContext context) {
    if (currentState is Loading || currentState is Initial) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
        ),
      );
    }

    if (currentState is Error) {
      //todo: more specific error message from the failure
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            S.of(context).somethingWentWrong,
            style: const TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ),
      );
    }

    if (movie == null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            S.of(context).noMovieAvailable,
            style: const TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ),
      );
    } else {
      return SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              Text(
                movie!.title ?? '',
                softWrap: true,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                movie!.description ?? '',
                softWrap: true,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${movie!.duration ?? 0}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        movie!.releaseDate != null &&
                                movie!.releaseDate!.isNotEmpty
                            ? movie!.releaseDate!
                            : '-?-',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.movie,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        movie!.director != null && movie!.director!.isNotEmpty
                            ? movie!.director!
                            : '-?-',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${movie!.rating ?? '-?-'}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

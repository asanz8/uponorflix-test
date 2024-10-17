import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/features/movie/presentation/widget/movie_item.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

class MovieList extends ConsumerWidget {
  final List<Movie> movies;
  final int totalCount;
  final BaseState currentState;

  const MovieList({
    super.key,
    required this.movies,
    required this.totalCount,
    required this.currentState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    if (movies.isEmpty) {
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
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == movies.length - 1 && movies.length != totalCount) {
                ref.read(movieNotifierProvider.notifier).loadMore();
              }

              final movie = movies[index];

              return MovieItem(
                key: Key('movie_item_${movie.id}'),
                movie: movie,
              );
            },
            childCount: movies.length,
          ),
        ),
      );
    }
  }
}

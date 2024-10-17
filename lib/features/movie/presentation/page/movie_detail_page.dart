import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_catalog_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_update_page.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_detail_provider.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/features/movie/presentation/widget/movie_details.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/dialog/delete_movie_dialog.dart';

class MovieDetailPage extends ConsumerStatefulWidget {
  final int movieId;
  static const id = "movie_detail_page";

  const MovieDetailPage({super.key, required this.movieId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieDetailPageState();
}

class _MovieDetailPageState extends ConsumerState<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(movieDetailNotifierProvider.notifier)
          .getMovieById(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieDetailNotifierProvider);
    final movieState = ref.watch(getMovieByIdState);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                S.of(context).movieDetails,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  key: const Key('edit_movie_button'),
                  icon: const Icon(
                    Icons.edit,
                    size: 24,
                    color: Colors.blueAccent,
                  ),
                  onPressed: movie == null
                      ? null
                      : () {
                          context.goNamed(
                            MovieUpdatePage.id,
                            pathParameters: {'id': movie.id.toString()},
                            extra: movie,
                          );
                        },
                ),
                IconButton(
                  key: const Key('delete_movie_button'),
                  icon: const Icon(
                    Icons.delete,
                    size: 24,
                    color: Colors.red,
                  ),
                  onPressed: movie == null
                      ? null
                      : () async {
                          // Show a dialog to confirm the deletion
                          final isDeleted = await showGeneralDialog<bool>(
                            context: context,
                            pageBuilder: (context, _, __) {
                              return const DeleteMovieDialog();
                            },
                          );

                          // If the user confirms the deletion, delete the movie
                          if (isDeleted != null && isDeleted) {
                            await ref
                                .read(movieNotifierProvider.notifier)
                                .deleteMovie(movie);
                            if (context.mounted) {
                              context.goNamed(MovieCatalogPage.id);
                            }
                          }
                        },
                ),
              ],
            ),
            MovieDetails(currentState: movieState, movie: movie),
          ],
        ),
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_add_page.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/features/movie/presentation/widget/movie_list.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

class MovieCatalogPage extends ConsumerStatefulWidget {
  static const id = "movie_catalog_page";

  const MovieCatalogPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieCatalogPageState();
}

class _MovieCatalogPageState extends ConsumerState<MovieCatalogPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieNotifierProvider.notifier).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesState = ref.watch(getMoviesState);
    final movieList = ref.watch(movieNotifierProvider);
    final totalCount = ref.watch(
        movieNotifierProvider.notifier.select((value) => value.totalCount));

    ref.listen<BaseState>(deleteMovieState, (previous, next) {
      if (next is Loaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Flushbar(
            title: '${next.data.title}',
            message: S.of(context).deletedSuccessfully,
            duration: const Duration(seconds: 3),
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          ).show(context);
        });
      }
    });

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(S.of(context).movieCatalog),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  key: const Key('add_movie_button'),
                  icon: const Icon(
                    Icons.add_circle,
                    size: 36,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    context.goNamed(MovieAddPage.id);
                  },
                ),
              ],
            ),
            MovieList(
              movies: movieList,
              totalCount: totalCount,
              currentState: moviesState,
            ),
          ],
        ),
      ),
    );
  }
}

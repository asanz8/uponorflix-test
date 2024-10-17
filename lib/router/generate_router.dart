import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_add_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_catalog_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_detail_page.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_update_page.dart';

// Generate the router, this will help in testing the navigation
GoRouter generateRouter() => GoRouter(initialLocation: '/movies', routes: [
      GoRoute(
          path: '/movies',
          name: MovieCatalogPage.id,
          builder: (context, state) => const MovieCatalogPage(),
          routes: [
            GoRoute(
              path: 'add',
              name: MovieAddPage.id,
              builder: (context, state) => const MovieAddPage(),
            ),
            GoRoute(
              path: ':id',
              name: MovieDetailPage.id,
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '0';

                return MovieDetailPage(movieId: int.parse(id));
              },
              routes: [
                GoRoute(
                  path: 'update',
                  name: MovieUpdatePage.id,
                  builder: (context, state) {
                    final movie = state.extra as Movie;

                    return MovieUpdatePage(movie: movie);
                  },
                )
              ],
            ),
          ]),
    ]);

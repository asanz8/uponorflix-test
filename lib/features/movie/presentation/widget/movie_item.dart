import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/presentation/page/movie_detail_page.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.goNamed(
          MovieDetailPage.id,
          pathParameters: {'id': movie.id.toString()},
        );
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.blueAccent,
        side: const BorderSide(color: Colors.transparent, width: 1),
      ),
      child: Text(
        movie.title ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}

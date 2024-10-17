import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_detail_provider.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/form/custom_date_picker.dart';
import 'package:uponorflix/shared/form/custom_number_field.dart';
import 'package:uponorflix/shared/form/custom_text_form_field.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

class MovieUpdatePage extends ConsumerStatefulWidget {
  static const id = "movie_update_page";

  final Movie movie;

  const MovieUpdatePage({super.key, required this.movie});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieUpdatePageState();
}

class _MovieUpdatePageState extends ConsumerState<MovieUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();

  double ratingValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Set initial values from the movie object
    titleController.text = widget.movie.title ?? '';
    descriptionController.text = widget.movie.description ?? '';
    durationController.text = '${widget.movie.duration}';
    imageUrlController.text = widget.movie.imageUrl ?? '';
    directorController.text = widget.movie.director ?? '';
    releaseDateController.text = widget.movie.releaseDate ?? '';
    ratingValue = widget.movie.rating ?? 0.0;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    imageUrlController.dispose();
    directorController.dispose();
    releaseDateController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final title = titleController.text;
      final description = descriptionController.text;
      final duration = int.tryParse(durationController.text) ?? 0;
      final imageUrl = imageUrlController.text;
      final director = directorController.text;
      final releaseDate = releaseDateController.text;

      final movie = Movie(
        id: widget.movie.id,
        title: title,
        description: description,
        duration: duration,
        imageUrl: imageUrl,
        director: director,
        releaseDate: releaseDate,
        rating: ratingValue,
      );

      await ref.read(movieNotifierProvider.notifier).updateMovie(movie);

      ref.read(movieDetailNotifierProvider.notifier).refreshMovie(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateMovieCurrentState = ref.watch(updateMovieState);

    // Listen to the update movie state
    ref.listen<BaseState>(updateMovieState, (previous, next) {
      // If the state is loaded, pop the page and show a success message
      if (next is Loaded) {
        context.pop();
        Flushbar(
          title: '${next.data.title}',
          message: S.of(context).updatedSuccessfully,
          duration: const Duration(seconds: 3),
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        ).show(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).updateMovie),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).updateMovieDetails,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomTextFormField(
                      controller: titleController,
                      label: S.of(context).title,
                      hint: S.of(context).enterTitle),
                  CustomTextFormField(
                      controller: descriptionController,
                      label: S.of(context).description,
                      hint: S.of(context).enterDescription),
                  CustomNumberField(
                      controller: durationController,
                      label: S.of(context).durationInMinutes,
                      hint: S.of(context).enterDuration),
                  CustomTextFormField(
                      controller: imageUrlController,
                      label: S.of(context).imageURL,
                      hint: S.of(context).enterImageURL,
                      isRequired: false),
                  CustomTextFormField(
                      controller: directorController,
                      label: S.of(context).director,
                      hint: S.of(context).enterDirector,
                      isRequired: false),
                  CustomDatePicker(
                      controller: releaseDateController,
                      label: S.of(context).releaseDate,
                      hint: S.of(context).enterReleaseDate,
                      isRequired: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Rating'),
                        ),
                        Slider(
                          label: ratingValue.toString(),
                          thumbColor: Colors.blueAccent,
                          activeColor: Colors.blue.shade300,
                          divisions: 10,
                          value: ratingValue,
                          onChanged: (value) {
                            setState(() {
                              ratingValue = value;
                            });
                          },
                          min: 0.0,
                          max: 5.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: updateMovieCurrentState is Loading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text(
                              S.of(context).update,
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

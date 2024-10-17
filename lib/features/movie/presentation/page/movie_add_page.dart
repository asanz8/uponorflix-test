import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/features/movie/domain/entities/movie.dart';
import 'package:uponorflix/features/movie/presentation/provider/movie_provider.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/shared/form/custom_date_picker.dart';
import 'package:uponorflix/shared/form/custom_number_field.dart';
import 'package:uponorflix/shared/form/custom_text_form_field.dart';
import 'package:uponorflix/shared/provider/base_state.dart';

class MovieAddPage extends ConsumerStatefulWidget {
  static const id = "movie_add_page";

  const MovieAddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieAddPageState();
}

class _MovieAddPageState extends ConsumerState<MovieAddPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();

  double ratingValue = 0.0;

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
        title: title,
        description: description,
        duration: duration,
        imageUrl: imageUrl,
        director: director,
        releaseDate: releaseDate,
        rating: ratingValue,
      );

      await ref.read(movieNotifierProvider.notifier).addMovie(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieAddCurrentState = ref.watch(addMovieState);

    // Listen to the state changes [addMovieState]
    ref.listen<BaseState>(addMovieState, (previous, next) {
      // If the state is loaded, pop the current page and show a flushbar
      if (next is Loaded) {
        context.pop();
        Flushbar(
          title: '${next.data.title}',
          message: S.of(context).addedSuccessfully,
          duration: const Duration(seconds: 3),
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        ).show(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addMovie),
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
                      S.of(context).enterMovieDetails,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomTextFormField(
                    controller: titleController,
                    label: S.of(context).title,
                    hint: S.of(context).enterTitle,
                    maxLength: 80,
                  ),
                  CustomTextFormField(
                    controller: descriptionController,
                    label: S.of(context).description,
                    hint: S.of(context).enterDescription,
                    maxLength: 500,
                  ),
                  CustomNumberField(
                    controller: durationController,
                    label: S.of(context).durationInMinutes,
                    hint: S.of(context).enterDuration,
                  ),
                  CustomTextFormField(
                    controller: imageUrlController,
                    label: S.of(context).imageURL,
                    hint: S.of(context).enterImageURL,
                    isRequired: false,
                  ),
                  CustomTextFormField(
                    controller: directorController,
                    label: S.of(context).director,
                    hint: S.of(context).enterDirector,
                    maxLength: 80,
                    isRequired: false,
                  ),
                  CustomDatePicker(
                    controller: releaseDateController,
                    label: S.of(context).releaseDate,
                    hint: S.of(context).enterReleaseDate,
                    isRequired: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(S.of(context).rating),
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
                      child: movieAddCurrentState is Loading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text(
                              S.of(context).submit,
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

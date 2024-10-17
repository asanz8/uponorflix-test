// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Catálogo de peliculas`
  String get movieCatalog {
    return Intl.message(
      'Catálogo de peliculas',
      name: 'movieCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Agregar película`
  String get addMovie {
    return Intl.message(
      'Agregar película',
      name: 'addMovie',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese detalles de la película`
  String get enterMovieDetails {
    return Intl.message(
      'Ingrese detalles de la película',
      name: 'enterMovieDetails',
      desc: '',
      args: [],
    );
  }

  /// `Agregado con éxito`
  String get addedSuccessfully {
    return Intl.message(
      'Agregado con éxito',
      name: 'addedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Título`
  String get title {
    return Intl.message(
      'Título',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese el título`
  String get enterTitle {
    return Intl.message(
      'Ingrese el título',
      name: 'enterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Por favor ingrese {value}`
  String requiredField(Object value) {
    return Intl.message(
      'Por favor ingrese $value',
      name: 'requiredField',
      desc: '',
      args: [value],
    );
  }

  /// `Descripción`
  String get description {
    return Intl.message(
      'Descripción',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese la descripción`
  String get enterDescription {
    return Intl.message(
      'Ingrese la descripción',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Por favor ingrese un número válido`
  String get enterValidNumber {
    return Intl.message(
      'Por favor ingrese un número válido',
      name: 'enterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Duración en minutos`
  String get durationInMinutes {
    return Intl.message(
      'Duración en minutos',
      name: 'durationInMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese la duración`
  String get enterDuration {
    return Intl.message(
      'Ingrese la duración',
      name: 'enterDuration',
      desc: '',
      args: [],
    );
  }

  /// `URL de la imagen`
  String get imageURL {
    return Intl.message(
      'URL de la imagen',
      name: 'imageURL',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese la URL de la imagen`
  String get enterImageURL {
    return Intl.message(
      'Ingrese la URL de la imagen',
      name: 'enterImageURL',
      desc: '',
      args: [],
    );
  }

  /// `Clasificación`
  String get rating {
    return Intl.message(
      'Clasificación',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Director`
  String get director {
    return Intl.message(
      'Director',
      name: 'director',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese el director`
  String get enterDirector {
    return Intl.message(
      'Ingrese el director',
      name: 'enterDirector',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de lanzamiento`
  String get releaseDate {
    return Intl.message(
      'Fecha de lanzamiento',
      name: 'releaseDate',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese la fecha de lanzamiento`
  String get enterReleaseDate {
    return Intl.message(
      'Ingrese la fecha de lanzamiento',
      name: 'enterReleaseDate',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get submit {
    return Intl.message(
      'Enviar',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Detalles de la película`
  String get movieDetails {
    return Intl.message(
      'Detalles de la película',
      name: 'movieDetails',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar película`
  String get updateMovie {
    return Intl.message(
      'Actualizar película',
      name: 'updateMovie',
      desc: '',
      args: [],
    );
  }

  /// `Actualizado con éxito`
  String get updatedSuccessfully {
    return Intl.message(
      'Actualizado con éxito',
      name: 'updatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar detalles de la película`
  String get updateMovieDetails {
    return Intl.message(
      'Actualizar detalles de la película',
      name: 'updateMovieDetails',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar`
  String get update {
    return Intl.message(
      'Actualizar',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Película no disponible`
  String get noMovieAvailable {
    return Intl.message(
      'Película no disponible',
      name: 'noMovieAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Algo salió mal`
  String get somethingWentWrong {
    return Intl.message(
      'Algo salió mal',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

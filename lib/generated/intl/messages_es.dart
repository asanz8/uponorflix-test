// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(value) => "Por favor ingrese ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addMovie": MessageLookupByLibrary.simpleMessage("Agregar película"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Agregado con éxito"),
        "deletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Deleted successfully"),
        "description": MessageLookupByLibrary.simpleMessage("Descripción"),
        "director": MessageLookupByLibrary.simpleMessage("Director"),
        "durationInMinutes":
            MessageLookupByLibrary.simpleMessage("Duración en minutos"),
        "enterDescription":
            MessageLookupByLibrary.simpleMessage("Ingrese la descripción"),
        "enterDirector":
            MessageLookupByLibrary.simpleMessage("Ingrese el director"),
        "enterDuration":
            MessageLookupByLibrary.simpleMessage("Ingrese la duración"),
        "enterImageURL":
            MessageLookupByLibrary.simpleMessage("Ingrese la URL de la imagen"),
        "enterMovieDetails": MessageLookupByLibrary.simpleMessage(
            "Ingrese detalles de la película"),
        "enterReleaseDate": MessageLookupByLibrary.simpleMessage(
            "Ingrese la fecha de lanzamiento"),
        "enterTitle": MessageLookupByLibrary.simpleMessage("Ingrese el título"),
        "enterValidNumber": MessageLookupByLibrary.simpleMessage(
            "Por favor ingrese un número válido"),
        "imageURL": MessageLookupByLibrary.simpleMessage("URL de la imagen"),
        "movieCatalog":
            MessageLookupByLibrary.simpleMessage("Catálogo de peliculas"),
        "movieDetails":
            MessageLookupByLibrary.simpleMessage("Detalles de la película"),
        "noMovieAvailable":
            MessageLookupByLibrary.simpleMessage("Película no disponible"),
        "rating": MessageLookupByLibrary.simpleMessage("Clasificación"),
        "releaseDate":
            MessageLookupByLibrary.simpleMessage("Fecha de lanzamiento"),
        "requiredField": m0,
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Algo salió mal"),
        "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
        "title": MessageLookupByLibrary.simpleMessage("Título"),
        "update": MessageLookupByLibrary.simpleMessage("Actualizar"),
        "updateMovie":
            MessageLookupByLibrary.simpleMessage("Actualizar película"),
        "updateMovieDetails": MessageLookupByLibrary.simpleMessage(
            "Actualizar detalles de la película"),
        "updatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Actualizado con éxito")
      };
}

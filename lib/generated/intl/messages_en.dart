// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(value) => "Please enter ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addMovie": MessageLookupByLibrary.simpleMessage("Add movie"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Added successfully"),
        "deletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Deleted successfully"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "director": MessageLookupByLibrary.simpleMessage("Director"),
        "durationInMinutes":
            MessageLookupByLibrary.simpleMessage("Duration in minutes"),
        "enterDescription":
            MessageLookupByLibrary.simpleMessage("Enter description"),
        "enterDirector": MessageLookupByLibrary.simpleMessage("Enter director"),
        "enterDuration": MessageLookupByLibrary.simpleMessage("Enter duration"),
        "enterImageURL":
            MessageLookupByLibrary.simpleMessage("Enter image URL"),
        "enterMovieDetails":
            MessageLookupByLibrary.simpleMessage("Enter movie details"),
        "enterReleaseDate":
            MessageLookupByLibrary.simpleMessage("Enter release date"),
        "enterTitle": MessageLookupByLibrary.simpleMessage("Enter title"),
        "enterValidNumber":
            MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
        "imageURL": MessageLookupByLibrary.simpleMessage("Image URL"),
        "movieCatalog": MessageLookupByLibrary.simpleMessage("Movie catalog"),
        "movieDetails": MessageLookupByLibrary.simpleMessage("Movie details"),
        "noMovieAvailable":
            MessageLookupByLibrary.simpleMessage("No movie available"),
        "rating": MessageLookupByLibrary.simpleMessage("Rating"),
        "releaseDate": MessageLookupByLibrary.simpleMessage("Release date"),
        "requiredField": m0,
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updateMovie": MessageLookupByLibrary.simpleMessage("Update movie"),
        "updateMovieDetails":
            MessageLookupByLibrary.simpleMessage("Update movie details"),
        "updatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Updated successfully")
      };
}

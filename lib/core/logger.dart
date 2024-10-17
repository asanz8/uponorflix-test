import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void initLogger() {
  if (kDebugMode) {
    // Log more when in debug mode.
    Logger.root.level = Level.FINE;
  }

  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}';

    debugPrint(message);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uponorflix/app.dart';
import 'package:uponorflix/core/logger.dart';
import 'package:uponorflix/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  initLogger();

  // Initialize dependency injection
  await di.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      const ProviderScope(
        child: App(),
      ),
    ),
  );
}

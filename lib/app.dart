import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/generated/l10n.dart';
import 'package:uponorflix/router/router.dart';

class App extends StatelessWidget {
  /// For testing purposes, reset the router in every test
  final GoRouter? testRouter;

  const App({super.key, this.testRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: testRouter ?? router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
    );
  }
}

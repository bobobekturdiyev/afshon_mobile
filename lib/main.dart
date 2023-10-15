import 'package:afshon_ar/core/di/injector.dart';
import 'package:afshon_ar/core/di/locator.dart';
import 'package:afshon_ar/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(Injector(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Afshon',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
      themeMode: ThemeMode.dark,
    );
  }
}

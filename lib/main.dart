import 'package:emenu/config/routes/router.dart' as router;
import 'package:emenu/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    _splashAction();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMenu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.mainPage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }

  void _splashAction() {
    new Future.delayed(
        const Duration(seconds: 2), () => FlutterNativeSplash.remove());
  }
}

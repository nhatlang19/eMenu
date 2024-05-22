import 'package:emenu/screens/main_page.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'MainPage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case 'TablePage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case 'OrderPage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case 'CartPage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}

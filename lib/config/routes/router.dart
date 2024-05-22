import 'package:emenu/modules/auth/main_page.dart';
import 'package:emenu/modules/cart/cart_page.dart';
import 'package:emenu/modules/order/order_page.dart';
import 'package:emenu/modules/table/table_page.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'MainPage':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case 'TablePage':
        return MaterialPageRoute(builder: (_) => const TablePage());
      case 'OrderPage':
        return MaterialPageRoute(builder: (_) => const OrderPage());
      case 'CartPage':
        return MaterialPageRoute(builder: (_) => const CartPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Text('No route defined for ${settings.name}'),
                )));
    }
  }
}

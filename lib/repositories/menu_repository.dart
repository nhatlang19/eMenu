import 'dart:async';

import 'package:emenu/models/menu.dart';
import 'package:emenu/models/submenu.dart';
import 'package:emenu/providers/menu_provider.dart';


enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class MenuRepository {
  Future<List<Menu>> getPosMenu({
    required String posGroup
  }) async {
    final provider = MenuProvider();

    var json = await provider.getPosMenu(posGroup);
    final List<Menu> result = [];
    for (var data in json) {
      result.add(Menu.fromJson(data['Table'] as Map<String, dynamic>));
    }
     
    return result;
  }

  Future<List<Submenu>> getSubsMenu({
    required String selectedPosMenu, required String posGroup,
  }) async {
    final provider = MenuProvider();

    var json = await provider.getSubMenu(selectedPosMenu, posGroup);
    final List<Submenu> result = [];
    for (var data in json) {
      result.add(Submenu.fromJson(data['Table'] as Map<String, dynamic>));
    }
     
    return result;
  }
}

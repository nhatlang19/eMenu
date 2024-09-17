import 'dart:io';

import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/asset_path.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuLeft extends StatelessWidget {
  const MenuLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
        // buildWhen: (previous, current) =>
        //     previous.menus.length != current.menus.length,
        builder: (context, state) {
      return Expanded(
        flex: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                        child: Image.asset(
                          AssetPath.loginLogo,
                          width: 200,
                        ),
                      ),
            ),
            Expanded(
                child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.builder(
                itemCount: state.menus.length,
                itemBuilder: (context, index) {
                  final menu = state.menus[index];
                  final selectedIndex = state.menus.indexOf(state.menu);
                  return ListTile(
                    selected: selectedIndex == index,
                    // tileColor: ColorUtil.parseColor(menu.btnColor),
                    textColor: Colors.white,
                    tileColor: AppColors.mainBLue,
                    // selectedTileColor: ColorUtil.parseColor(menu.btnColor,
                    //     alpha: 0.5), // Background color for non-selected state
                    selectedColor: Colors.white,
                    selectedTileColor: AppColors.mainRed,
                    title: Text(
                      menu.description,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      // Handle item tap
                      context.read<MenuBloc>().add(ChangeMenu(menu: menu));
                      context.read<SubMenuBloc>().add(FetchSubmenu(
                          selectedPosMenu: menu.defaultValue,
                          posGroup: state.posGroup));
                    },
                  );
                },
              ),
            )),
          ],
        ),
      );
    });
  }
}

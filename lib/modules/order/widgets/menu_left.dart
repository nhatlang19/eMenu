import 'package:emenu/config/themes/app_colors.dart';
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
        buildWhen: (previous, current) =>
            previous.menus.length != current.menus.length,
        builder: (context, state) {
          return Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  color: AppColors.mainBLue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const Center(
                          child: Text(
                        "MENU",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                      IconButton(
                        iconSize: 54.0,
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: state.menus.length,
                  itemBuilder: (context, index) {
                    final menu = state.menus[index];
                    final selectedIndex = state.menus.indexOf(state.menu);
                    return ListTile(
                      selected: selectedIndex == index,
                      tileColor: ColorUtil.parseColor(menu.btnColor),
                      selectedTileColor: ColorUtil.parseColor(menu.btnColor,
                          alpha:
                              0.5), // Background color for non-selected state
                      title: Text(
                        menu.description,
                        style: TextStyle(
                          color: ColorUtil.parseColor(
                              menu.fontColor), // Text color
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
                )),
              ],
            ),
          );
        });
  }
}

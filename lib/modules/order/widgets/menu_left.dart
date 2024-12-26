import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/asset_path.dart';
import 'package:emenu/models/setting.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuLeft extends StatelessWidget {
  const MenuLeft({super.key});

  Future<Setting> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting;
  }

  Widget loadLogo(Setting setting) {
    if (setting.serverIP != '') {
      var pathLogo = Global.logoPath(setting.serverIP) + setting.logoName;
      return Image.network(
        pathLogo,
        height: 100,
      );
    }
    return Image.asset(
      AssetPath.loginLogo,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Setting>(
        future: _getSettings(),
        builder: (BuildContext context, AsyncSnapshot<Setting> snapshot) {
          if (snapshot.hasData) {
            Setting? setting = snapshot.data;
            if (setting != null) {
              return _buildUI(setting);
            }
          }
          return _buildUI(Setting.empty);
        });
  }

  Widget _buildUI(Setting setting) {
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
              child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) => current.refreshLogo == true,
                builder: (context, state) {
                  return Center(
                    child: loadLogo(state.setting),
                  );
                },
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // Handle item tap
                      context.read<CartBloc>().add(const Close());
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

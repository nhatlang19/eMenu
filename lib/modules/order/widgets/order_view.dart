import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/menu_grid_right.dart';
import 'package:emenu/modules/order/widgets/menu_left.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  Future<String> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting.posGroup;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _getSettings(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return MultiBlocListener(
                listeners: [
                  BlocListener<MenuBloc, MenuState>(
                    listener: (context, state) {
                      if (state.status == MenuStatus.success) {
                        context.read<SubMenuBloc>().add(FetchSubmenu(
                            selectedPosMenu: state.menu.defaultValue,
                            posGroup: '${snapshot.data}'));
                      }
                    },
                  ),
                ],
                child: const Center(
                  child: Row(
                    children: <Widget>[MenuLeft(), MenuGridRight()],
                  ),
                ));
          }
          return const Placeholder();
        });
  }
}

import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/menu_grid_right.dart';
import 'package:emenu/modules/order/widgets/menu_left.dart';
import 'package:emenu/modules/order/widgets/order_view.dart';
import 'package:emenu/repositories/menu_repository.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late final MenuRepository menuRepository;

  @override
  void initState() {
    super.initState();
    menuRepository = MenuRepository();
  }

  Future<String> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting.posGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   title: const Text('Order'),
        // ),
        body: FutureBuilder<String>(
            future: _getSettings(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
               if (snapshot.hasData) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<MenuBloc>(
                        create: (BuildContext context) => MenuBloc(menuRepository: menuRepository)..add(FetchMenu(posGroup: '${snapshot.data}')),
                      ),
                      BlocProvider<SubMenuBloc>(
                        create: (BuildContext context) => SubMenuBloc(menuRepository: menuRepository),
                      ),
                    ],
                    child: const OrderView()
                  );
               }
               return const Placeholder();
            }
          ));
  }
}

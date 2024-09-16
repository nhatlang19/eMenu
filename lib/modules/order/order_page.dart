import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/menu_grid_right.dart';
import 'package:emenu/modules/order/widgets/menu_left.dart';
import 'package:emenu/modules/order/widgets/order_view.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/repositories/item_repository.dart';
import 'package:emenu/repositories/menu_repository.dart';
import 'package:emenu/repositories/order_repository.dart';
import 'package:emenu/repositories/section_repository.dart';
import 'package:emenu/repositories/table_repository.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  final Map args;

  const OrderPage(this.args, {super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late final MenuRepository menuRepository;
  late final ItemRepository itemRepository;
  late final OrderRepository orderRepository;
  late final SectionRepository sectionRepository;
  late final TableRepository tableRepository;

  late Map args;
  @override
  void initState() {
    super.initState();
    args = widget.args;
    menuRepository = MenuRepository();
    itemRepository = ItemRepository();
    orderRepository = OrderRepository();
    sectionRepository = SectionRepository();
    tableRepository = TableRepository();
  }

  Future<String> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting.posGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBLue,
        // appBar: AppBar(
        //   title: const Text('Order'),
        // ),
        body: FutureBuilder<String>(
            future: _getSettings(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return MultiBlocProvider(providers: [
                  BlocProvider<OrderBloc>(
                    create: (BuildContext context) => OrderBloc(orderRepository: orderRepository)
                      ..add(OrderInitPage(
                          selectedForGroup: args["tableGroup"],
                          isAddNew: args["tableStatus"],
                          tableSection: args["tableSection"],
                          order: args["order"],
                          selectedTable: args["selectedTable"],
                          selectedCode: args["selectedCode"])),
                  ),
                  BlocProvider<MenuBloc>(
                    create: (BuildContext context) =>
                        MenuBloc(menuRepository: menuRepository)
                          ..add(FetchMenu(posGroup: '${snapshot.data}')),
                  ),
                  BlocProvider<SubMenuBloc>(
                    create: (BuildContext context) =>
                        SubMenuBloc(menuRepository: menuRepository),
                  ),
                  BlocProvider<SectionBloc>(
                        create: (BuildContext context) => SectionBloc(sectionRepository: sectionRepository)..add(FetchSection()),
                  ),
                  BlocProvider<TableBloc>(
                    create: (BuildContext context) => TableBloc(tableRepository: tableRepository),
                  ),
                ], child: const OrderView());
              }
              return const CircularProgressIndicator();
            }
      )
    );
  }
}

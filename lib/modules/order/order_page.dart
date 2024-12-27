import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/table.dart';
import 'package:emenu/models/user.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/order_view.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/repositories/item_repository.dart';
import 'package:emenu/repositories/menu_repository.dart';
import 'package:emenu/repositories/order_repository.dart';
import 'package:emenu/repositories/section_repository.dart';
import 'package:emenu/repositories/table_repository.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emenu/models/table.dart' as table_model;

class OrderPage extends StatefulWidget {
  final Map args;

  const OrderPage(this.args, {super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with WidgetsBindingObserver {
  late final MenuRepository menuRepository;
  late final ItemRepository itemRepository;
  late final OrderRepository orderRepository;
  late final SectionRepository sectionRepository;
  late final TableRepository tableRepository;
  late table_model.Table table;
  late BuildContext myContext;

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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  Future<void> doCallUpdateTableStatus(String status, User cashier) async {
    var res = await tableRepository.updateTableStatus(
                status: status, 
                cashierId: cashier.cashierID ?? '',
                currentTable: table.TableNo ?? '');
    print("[doCallUpdateTableStatus] ${status} ${res}");
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    var cashier = await Global.getCashier();
    try {
      switch(state) {
        case AppLifecycleState.resumed:
          doCallUpdateTableStatus(TableConstant.STATUS_OPEN, cashier);
          break;
        case AppLifecycleState.detached:
        case AppLifecycleState.inactive:
        case AppLifecycleState.hidden:
        case AppLifecycleState.paused:
          doCallUpdateTableStatus(TableConstant.STATUS_CLOSE, cashier);
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting.posGroup;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.mainBLue,
          body: FutureBuilder<String>(
              future: _getSettings(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  table = args["selectedTable"];
                  myContext = context;
                  return MultiBlocProvider(providers: [
                    BlocProvider<OrderBloc>(
                      create: (BuildContext context) => OrderBloc(orderRepository: orderRepository, tableRepository: tableRepository)
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
                          create: (BuildContext context) => SectionBloc(sectionRepository: sectionRepository)..add(const FetchSection()),
                    ),
                    BlocProvider<TableBloc>(
                      create: (BuildContext context) => TableBloc(tableRepository: tableRepository),
                    ),
                  ], child: const OrderView());
                }
                return const CircularProgressIndicator();
              }
        )
      ),
    );
  }

  
}

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/order_view.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/repositories/auth_repository.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          // var settings = Settings();
          // var setting = await settings.read();
          // if (setting.isCashier == "1") {
          //   // ignore: use_build_context_synchronously
          //   _showCustomDialog(context);
          // } else {
          //   // ignore: use_build_context_synchronously
          //   context.read<CartBloc>().add(const ResetCart());
          //   // ignore: use_build_context_synchronously
          //   Navigator.pop(context);
          // }
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.mainBLue,
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

  void _showCustomDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) =>
              LoginBloc(authenticationRepository: AuthRepository()),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.confirmStatus == ConfirmStatus.success) {
                Navigator.pop(context);
                context.read<CartBloc>().add(const ResetCart());
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop("REFRESH_TABLE");
                }
              } else if (state.confirmStatus == ConfirmStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text("Invalid username or password")),
                    );
              }
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5, // Custom width
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: AppTextStyles.dialogTitle,
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.username != current.username,
                      builder: (context, state) {
                        return TextFormField(
                          onChanged: (username) => context
                              .read<LoginBloc>()
                              .add(LoginUsernameChanged(username)),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            errorText: state.username.displayError != null
                                ? 'invalid username'
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.password != current.password,
                      builder: (context, state) {
                        return TextFormField(
                          onChanged: (password) => context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(password)),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            errorText: state.username.displayError != null
                                ? 'invalid password'
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (state.isValid) {
                                    context.read<LoginBloc>().add(const LoginConfirmed());
                                  }
                                },
                                child: const Text('OK'),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

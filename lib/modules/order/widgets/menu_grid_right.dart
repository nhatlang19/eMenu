import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/auth/bloc/login_bloc.dart';
import 'package:emenu/modules/cart/cart_view_drawer.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/grid_item.dart';
import 'package:emenu/repositories/auth_repository.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:emenu/utils/settings.dart';
import 'package:emenu/widgets/number_keyboards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class MenuGridRight extends StatelessWidget {
  const MenuGridRight({super.key});

  @override
  Widget build(BuildContext context) {
    late OverlayEntry overlayEntry;
    return Expanded(
      flex: 4,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: AppColors.mainRed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox.fromSize(
                      size: const Size(40, 40), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange, // button color
                          child: GestureDetector(
                            // splashColor: Colors.green, // splash color
                            onTapDown: (details) {
                              OverlayState overlayState = Overlay.of(context);
                              overlayEntry = OverlayEntry(builder: (context) {
                                return Stack(
                                  children: [
                                    Positioned(
                                      top: details.globalPosition.dy + 10,
                                      left: details.globalPosition.dx + 10,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              NumberKeyboards(
                                                onKeyPressed: (value) {
                                                  context.read<CartBloc>().add(
                                                      UpdateNoPeople(
                                                          value: value));
                                                },
                                                onClose: () {
                                                  try {
                                                    overlayEntry?.remove();
                                                  } catch (_) {}
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                              overlayState.insert(overlayEntry);
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                BlocBuilder<CartBloc, CartState>(
                                    buildWhen: (previous, current) =>
                                        previous.noPeople != current.noPeople,
                                    builder: (context, state) {
                                      return Text(state.noPeople);
                                    }), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<MenuBloc, MenuState>(
                        buildWhen: (previous, current) =>
                            previous.menu.defaultValue !=
                            current.menu.defaultValue,
                        builder: (context, state) {
                          return Expanded(
                              child: Center(
                                  child: Text(
                            state.menu.description,
                            style: AppTextStyles.tableTitleWhite,
                          )));
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return Text(
                                "Bàn ${state.selectedTable.TableNo.trim()}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold));
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, right: 5),
                          child: Text('|',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          iconSize: 50.0,
                          icon: const Icon(Icons.exit_to_app),
                          color: Colors.white,
                          onPressed: () async {
                            var settings = Settings();
                            var setting = await settings.read();
                            if (setting.isCashier == "1") {
                              // ignore: use_build_context_synchronously
                              _showCustomDialog(context);
                            } else {
                              // ignore: use_build_context_synchronously
                              context.read<CartBloc>().add(const ResetCart());
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) =>
                      previous.toogle != current.toogle,
                  builder: (context, stateCart) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: BlocBuilder<SubMenuBloc, SubmenuState>(
                                  // buildWhen: (previous, current) =>
                                  //     previous.menu.defaultValue != current.menu.defaultValue,
                                  builder: (context, state) {
                                var crossAxisCount =
                                    ScreenUtil.isPortrait(context)
                                        ? 3
                                        : (stateCart.toogle ? 3 : 5);
                                crossAxisCount = 2;
                                return MediaQuery.removePadding(
                                  context: context,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: GridView.builder(
                                          padding: const EdgeInsets.all(5),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      crossAxisCount, // Number of columns in the grid
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 1,
                                                  childAspectRatio: 22 / 9),
                                          itemCount: state.submenus
                                              .length, // Number of items in the grid
                                          itemBuilder: (context, index) {
                                            return GridItem(
                                                index, state.submenus[index]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                color: AppColors.mainRed,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<CartBloc, CartState>(
                          buildWhen: (previous, current) =>
                              previous.cartItems.length !=
                                  current.cartItems.length ||
                              current.status == CartStatus.updatedQuantity ||
                              current.status == CartStatus.success,
                          builder: (context, state) {
                            var total = ScreenUtil.formatPrice(state.total);
                            return Padding(
                              padding: const EdgeInsets.only(right: 40.0),
                              child: Text('Tạm tính: $total đ',
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<CartBloc>().add(const Toogle());
                              },
                              child: BlocBuilder<CartBloc, CartState>(
                                  buildWhen: (previous, current) =>
                                      previous.cartItems.length !=
                                      current.cartItems.length,
                                  builder: (context, state) {
                                    final cartItemCount =
                                        state.cartItems.length;
                                    return badges.Badge(
                                      position: badges.BadgePosition.bottomEnd(
                                          bottom: -10, end: -12),
                                      badgeContent: Text(
                                        '$cartItemCount',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      badgeStyle: const badges.BadgeStyle(
                                        badgeColor: Colors.red,
                                      ),
                                      child: const Icon(Icons.shopping_cart,
                                          color: Colors.white, size: 50.0),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.toogle != current.toogle,
              builder: (context, stateCart) {
                return Positioned(
                  top: 0,
                  right: 0,
                  child: stateCart.toogle
                      ? const CartViewDrawer()
                      : const SizedBox(width: 0),
                );
              })
        ],
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

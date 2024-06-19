import 'dart:io';

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/cart/cart_view.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:emenu/modules/order/widgets/grid_item.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;

class MenuGridRight extends StatelessWidget {
  const MenuGridRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          Container(
            color: AppColors.mainBLue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                BlocBuilder<MenuBloc, MenuState>(
                    buildWhen: (previous, current) =>
                        previous.menu.defaultValue != current.menu.defaultValue,
                    builder: (context, state) {
                      return Expanded(
                          child: Center(
                              child: Text(
                        state.menu.description,
                        style: AppTextStyles.tableTitleWhite,
                      )));
                    }),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, 'CartPage');
                          context.read<CartBloc>().add(Toogle());
                        },
                        child: BlocBuilder<CartBloc, CartState>(
                            buildWhen: (previous, current) =>
                                previous.cartItems.length !=
                                current.cartItems.length,
                            builder: (context, state) {
                              final cartItemCount = state.cartItems.length;
                              return badges.Badge(
                                position: badges.BadgePosition.bottomEnd(
                                    bottom: -10, end: -12),
                                badgeContent: Text(
                                  '$cartItemCount',
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: Colors.red,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                )
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
                          padding: const EdgeInsets.all(6.0),
                          child: BlocBuilder<SubMenuBloc, SubmenuState>(
                              // buildWhen: (previous, current) =>
                              //     previous.menu.defaultValue != current.menu.defaultValue,
                              builder: (context, state) {
                            return MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: ScreenUtil.isPortrait(context)
                                      ? 3
                                      : (stateCart.toogle ? 3 : 5), // Number of columns in the grid
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: stateCart.toogle ? 1.3 : 1
                                ),
                                itemCount: state.submenus
                                    .length, // Number of items in the grid
                                itemBuilder: (context, index) {
                                  return GridItem(index, state.submenus[index]);
                                },
                              ),
                            );
                          })),
                    ),
                    Expanded(
                        flex: stateCart.toogle ? 1 : 0,
                        child: stateCart.toogle
                            ? CartView()
                            : SizedBox(width: 0))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

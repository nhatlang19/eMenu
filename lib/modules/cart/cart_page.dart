import 'dart:io';

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) =>
                previous.cartItems.length != current.cartItems.length,
            builder: (context, state) {
          var total = ScreenUtil.formatPrice(state.total);
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Expanded(
                      child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        // final selectedIndex = state.cartItems.indexOf(state.menu);
                        return ListTile(
                          // selected: selectedIndex == index,
                          // tileColor: ColorUtil.parseColor(menu.btnColor),
                          // selectedTileColor: ColorUtil.parseColor(menu.btnColor,
                          //     alpha: 0.5), // Background color for non-selected state
                          title: Text(item.item.recptDesc,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${item.item.unitSellPrice} VND x ${item.qty}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w400)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle item tap
                            // context.read<MenuBloc>().add(ChangeMenu(menu: menu));
                            // context.read<SubMenuBloc>().add(FetchSubmenu(
                            //     selectedPosMenu: menu.defaultValue,
                            //     posGroup: state.posGroup));
                          },
                        );
                      },
                    ),
                  )),
                ),
                Container(
                  color: AppColors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.all(Platform.isAndroid ? 1.0 : 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Tổng tiền: ${total} VND',
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        const SizedBox(),
                        Container(
                          padding: const EdgeInsets.all(
                              8.0), // Optional padding around the button
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.white, // Right border color
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              // Your onPressed logic here
                            },
                            child: Text('SEND ORDER >>> ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide.none, // Remove the default border
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12.0), // Button padding
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

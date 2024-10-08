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
                previous.cartItems.length != current.cartItems.length || current.status == CartStatus.updatedQuantity,
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
                            return ListTile(
                              title: Text(item.item.recptDesc,
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${ScreenUtil.formatPrice(item.item.getOrgPrice())} VND',
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                        top: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                        bottom: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        context.read<CartBloc>().add(Decrease(position: index));
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    width: 60,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder
                                            .none, // Remove underline border
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: TextEditingController(
                                          text: item.qty.toString()),
                                      onChanged: (newValue) {
                                        final newQuantity =
                                            int.tryParse(newValue);
                                        if (newQuantity != null &&
                                            newQuantity > 0) {
                                          context.read<CartBloc>().add(UpdateQuantity(position: index, value: newQuantity));
                                          
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                        top: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                        bottom: BorderSide(
                                          color:
                                              Colors.grey, // Right border color
                                          width: 1.0, // Border width
                                        ),
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        context.read<CartBloc>().add(Increase(position: index));
                                      },
                                    ),
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
                                child: const Text('SEND ORDER >>> ',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide
                                      .none, // Remove the default border
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

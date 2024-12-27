import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/asset_path.dart';
import 'package:emenu/models/submenu.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridItem extends StatelessWidget {
  final int index;
  final Submenu submenu;
  const GridItem(this.index, this.submenu, {super.key});

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        var price = ScreenUtil.formatPrice(submenu.price);
        return Card(
              color: AppColors.cardOrder,
              elevation: 4,
              margin: const EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(flex: 3, child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)), // Rounded corners
                        child: CachedNetworkImage(
                          width: 300, height: 250,
                          imageUrl: submenu.bitmap ?? AssetPath.bitmapDefault,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.fill,
                        ),
                      ),
                      submenu.isRunOut() ? Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.all(10), // Add padding around the text
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7), // Transparent black background
                                borderRadius: BorderRadius.circular(10), // Rounded borders
                              ),
                              child: const Text(
                                "TẠM HẾT",
                                style: TextStyle(
                                  color: Colors.white, // White text color
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ) : const SizedBox(width: 0,),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: 
                            BlocBuilder<CartBloc, CartState>(
                              buildWhen: (previous, current) =>
                                previous.cartItems.length != current.cartItems.length || current.status == CartStatus.updatedQuantity || current.status == CartStatus.success,
                              builder: (context, state) {
                                int quanlity = 0;
                                for (var item in state.cartItems) {
                                  if (item.item.itemCode.trim() == submenu.defaultValue.trim()) {
                                    quanlity += item.qty;
                                  }
                                }
                                if (quanlity == 0) {
                                  return const SizedBox(width: 0,);
                                }
                                return SizedBox.fromSize(
                                  size: const Size(38, 38), // button width and height
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.orange, // button color
                                      child: GestureDetector(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                          AutoSizeText("$quanlity", maxLines: 1, 
                                                style: const TextStyle(
                                                    color: Colors.white, fontSize: 20))
                                              // text
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                            }), 
                        ),
                    ],
                  ),),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            submenu.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                                maxLines: 4, // Limit to one line
                          ),
                          Text(
                            '$price đ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              !submenu.isRunOut() ? Positioned(
                bottom: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    if (!submenu.isRunOut()) {
                      context.read<CartBloc>().add(const Close());
                      context.read<CartBloc>().add(AddToCart(
                          currSubItem: submenu,
                          qty: 1,
                          priceLevel: state.selectedCode.priceLevel));
                    }
                  },
                  child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[400],
                      size: 45,
                    ),
                ),
              ) : const SizedBox(),
            ],
          ));
      },
    );
  }
}

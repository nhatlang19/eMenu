import 'dart:io';

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
        return InkWell(
          onTap: () {
            context.read<CartBloc>().add(AddToCart(
                currSubItem: submenu, qty: 1, priceLevel: state.selectedCode.priceLevel));
          },
          child: Card(
            color: AppColors.cardOrder,
            elevation: 4,
            margin: const EdgeInsets.all(2),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CachedNetworkImage(
                        imageUrl: submenu.bitmap ?? AssetPath.bitmapDefault,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        fit: BoxFit.fitHeight,
                      ),
                    Flexible(
                      flex: 1,
                      child: 
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                submenu.description,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                '$price đ',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.grey[400],
                    size: 45,
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }
}

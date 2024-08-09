import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/models/submenu.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
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
        return InkWell(
          onTap: () {
            context.read<CartBloc>().add(AddToCart(
                currSubItem: submenu, qty: 1, priceLevel: state.selectedCode.priceLevel));
          },
          child: Card(
            color: Colors.white,
            elevation: 1,
            margin: const EdgeInsets.all(2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                Stack(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1602881917760-7379db593981?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Zm9vZCUyMGJvd2x8ZW58MHx8MHx8fDA%3D',
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                        height: Platform.isAndroid ? 130 : 110,
                        width: Platform.isAndroid ? 130 : 110,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    left: 5,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 0),
                  child: Center(
                    child: Text(
                      submenu.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

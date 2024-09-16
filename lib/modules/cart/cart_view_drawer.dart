import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/modules/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewDrawer extends StatelessWidget {
  const CartViewDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Border color
                        width: 1.0,         // Border width
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<CartBloc, CartState>(
                        buildWhen: (previous, current) => previous.noPeople != current.noPeople,
                        builder: (context, state) {
                          return IconButton(
                            iconSize: 40.0,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              context.read<CartBloc>().add(Toogle());
                            },
                          );
                        }
                        ), // t
                        Text("Danh sách món đã gọi", style: TextStyle(fontSize: 20),),
                        const SizedBox(width: 1)
                      ],
                    ),
                  ),
                ),
                CartView()
              ],
            )
        ),
    );
  }
}
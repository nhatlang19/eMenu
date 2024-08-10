import 'package:emenu/models/order.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillDropdown extends StatelessWidget {
  const BillDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (previous, current) => previous.order.ordExt != current.order.ordExt,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Bill: ',
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<Order>(
                        value: state.order.ordExt == '' ? null : state.order,
                        onChanged: (Order? newValue) {
                          context.read<OrderBloc>().add(ChangeSelectOrder(order: newValue ?? state.order));
                        },
                        items: state.orders.map<DropdownMenuItem<Order>>((Order order) {
                          return DropdownMenuItem<Order>(
                            value: order,
                            child: Text(order.ordExt),
                          );
                        }).toList(),
                      ))),
                ),
              ],
            ));
      },
    );
  }
}

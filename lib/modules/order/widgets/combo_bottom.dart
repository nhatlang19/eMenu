import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComboBottom extends StatelessWidget {
  const ComboBottom({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          height: screenHeight * 0.9,
          width: screenWidth * 0.9,
          padding: EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(// Color of the bottom border
                    width: 0.5, 
                  ),
                ),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(const HideShowCombo());
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close, size: 30.0),
                      ),
                      Text(
                        'Add New Item: ${state.cartItemTmp.item.recptDesc} x ${state.cartItemTmp.qty}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCartWithCombo(callback: () =>  Navigator.pop(context)));
                        },
                        child: const Text('Add To Cart'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                    children:
                        state.cartItemTmp.cartItemComboList.map((parentItem) {
                  // int index = state.cartItemTmp.cartItemComboList.indexOf(parentItem) + 1;
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: ListTile(
                          // title: Text("Item $index"),
                          title: Text(parentItem.itemCombo.itemDesc.toString()),
                        ),
                      ),
                      Column(children: parentItem.cartItemModifierList.map((child) {
                        int quantity = 0;
                        if(child.hasDefaultValue) {
                          quantity = parentItem.maxQuantity;
                        }
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  child.itemModifier.modDesc.toString(),
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                              const Expanded(flex: 4, child: SizedBox(width: 8.0)),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: TextEditingController(text: quantity.toString()),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1), // Limit to 1 characters
                                  ],
                                  decoration: InputDecoration(
                                    hintText: quantity.toString(),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                    ],
                  );
                }).toList()),
              )
            ],
          ),
        );
      },
    );
  }
}

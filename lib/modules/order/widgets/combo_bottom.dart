import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/utils/screen_util.dart';
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
                          context.read<CartBloc>().add(HideShowCombo());
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, size: 30.0),
                      ),
                      Text(
                        'Add New Item: ${state.cartItemTmp.item.recptDesc} x ${state.cartItemTmp.qty}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCartWithCombo());
                          Navigator.pop(context);
                        },
                        child: Text('Add To Cart'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                    children:
                        state.cartItemTmp.cartItemComboList.map((parentItem) {
                  int index =
                      state.cartItemTmp.cartItemComboList.indexOf(parentItem) +
                          1;
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: ListTile(
                          title: Text("Item $index"),
                        ),
                      ),
                      Column(
                          children:
                              parentItem.cartItemModifierList.map((child) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  child.itemModifier.modDesc.toString(),
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              Expanded(flex: 4, child: SizedBox(width: 8.0)),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: TextEditingController(
                                      text: child.quantity.toString()),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        2), // Limit to 2 characters
                                  ],
                                  decoration: InputDecoration(
                                    hintText: '${child.quantity}',
                                    border: OutlineInputBorder(),
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

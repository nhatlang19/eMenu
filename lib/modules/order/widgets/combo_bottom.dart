import 'package:auto_size_text/auto_size_text.dart';
import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/widgets/number_keyboards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComboBottom extends StatefulWidget {
  const ComboBottom({super.key});

  @override
  State<ComboBottom> createState() => _ComboBottomState();
}

class _ComboBottomState extends State<ComboBottom> {
  final List<TextEditingController> _controllers = List.generate(1000, (_)=>TextEditingController());
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => previous.status != current.status && current.status == CartStatus.updatedQuantityCombo
      || current.status == CartStatus.addToCartComboFailure,
      builder: (context, state) {
        var isFail = state.status == CartStatus.addToCartComboFailure && state.errorMessage.isNotEmpty;
        Widget errorText = isFail ? Center(child: Text(state.errorMessage, style: const TextStyle(fontSize: 20.0, color: Colors.red))) : const SizedBox(height: 0,);
        return Container(
          height: screenHeight * 0.9,
          width: screenWidth * 0.9,
          padding: const EdgeInsets.all(0.0),
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
                      AutoSizeText(
                        '${state.cartItemTmp.item.recptDesc} x ${state.cartItemTmp.qty}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 1
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
              errorText,
              Expanded(
                child: ListView(
                    children:
                        state.cartItemTmp.cartItemComboList.map((parentItem) {
                  int comboIndex = state.cartItemTmp.cartItemComboList.indexOf(parentItem);
                  return Column(
                    children: [
                      Container(
                        color: const Color(0xFF4682B4),
                        child: ListTile(
                          title: Text("Món tự chọn ${comboIndex + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                          // title: Text(parentItem.itemCombo.itemDesc.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                        ),
                      ),
                      Column(children: parentItem.cartItemModifierList.map((child) {
                        int modifierIndex = parentItem.cartItemModifierList.indexOf(child);
                        int quantity = child.quantity;
                        // if(quantity == 0 && child.hasDefaultValue) {
                        //   quantity = parentItem.maxQuantity;
                        // }
                        int index = comboIndex * 10 + modifierIndex;
                        _controllers[index].text = quantity.toString();
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
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  controller: _controllers[index],
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2), // Limit to 1 characters
                                  ],
                                  decoration: InputDecoration(
                                    hintText: quantity.toString(),
                                    border: const OutlineInputBorder(),
                                  ),
                                  onTap: () {
                                    _showCustomDialog(context, _controllers[index], quantity.toString(), modifierIndex, comboIndex);
                                  // },
                                  // onChanged: (newValue) {
                                  //   final newQuantity = int.tryParse(newValue);
                                  //   if (newQuantity != null && newQuantity >= 0) {
                                  //     context.read<CartBloc>().add(
                                  //         UpdateQuantityCombo(
                                  //             position: modifierIndex,
                                  //             value: newQuantity,
                                  //             comboPosition: comboIndex));
                                  //   }
                                  },
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

  void _showCustomDialog(BuildContext parentContext
  , TextEditingController controller
  , String quantity
  , int modifierIndex
  , int comboIndex) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.1, // Custom width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: controller,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2), // Limit to 1 characters
                    ],
                    decoration: InputDecoration(
                      hintText: quantity,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                NumberKeyboards(
                    onKeyPressed: (value) {
                      var result = controller.text;
                      if (value == 'C') {
                        result = "1";
                      } else if (value == '←') {
                        if (result.length == 1) {
                          result = "0";
                        } else {
                          result = result.substring(0, result.length - 1);
                        }
                      } else {
                        if (result== '0') {
                          result = value;
                        } else {
                          var newValue = "$result$value";
                          if (newValue.isNotEmpty) {
                            if (newValue.length <= 2) {
                              result = newValue;
                            } else {
                              newValue = newValue.substring(1);
                              result = newValue;
                            }
                          }
                        }
                      }
                      controller.text = result;
                    },
                    onClose: () {
                      final newQuantity = int.tryParse(controller.text);
                      if (newQuantity != null && newQuantity >= 0) {
                        context.read<CartBloc>().add(
                            UpdateQuantityCombo(
                                position: modifierIndex,
                                value: newQuantity,
                                comboPosition: comboIndex));
                      }
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenItem extends StatefulWidget {
  const OpenItem({super.key});

  @override
  State<OpenItem> createState() => _OpenItemState();
}

class _OpenItemState extends State<OpenItem> {
  final _quanlityController = TextEditingController();
  final _pricingController = TextEditingController();

  @override
  void dispose() {
    _quanlityController.dispose();
    _pricingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        _pricingController.text = ScreenUtil.convertDoubleToInt(state.cartItemTmp.item.getOrgPrice());
        return Container(
          width: MediaQuery.of(context).size.width * 0.5, // Custom width
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.cartItemTmp.item.recptDesc,
                style: AppTextStyles.dialogTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quanlityController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3), // Limit to 2 characters
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Số lượng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  errorText: null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pricingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8), // Limit to 8 characters
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Giá',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  errorText: null,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(const HideShowOpenItem());
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                        .read<CartBloc>()
                        .add(AddToCartWithOpenItem(
                          qty: _quanlityController.text,
                          price: _pricingController.text,
                          callback: () =>  Navigator.pop(context)));
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

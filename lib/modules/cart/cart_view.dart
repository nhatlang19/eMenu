import 'dart:io';

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item.dart';
import 'package:emenu/config/routes/routes.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/order.dart';
import 'package:emenu/modules/confirm/confirm_page.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.sendOrderFail) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
        } else if (state.status == CartStatus.sendOrderSuccess) {
          //context.read<CartBloc>().add(ResetCart());
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop("REFRESH_TABLE");
          }
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) =>
              previous.cartItems.length != current.cartItems.length ||
              current.status == CartStatus.updatedQuantity ||
              current.status == CartStatus.success,
          builder: (context, state) {
            var total = ScreenUtil.formatPrice(state.total);
            return Expanded(
              child: Container(
                color: Colors.white70,
                child: Column(
                  children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                        child: Table(
                          // border: TableBorder, // Adds borders to the table
                          columnWidths: {
                            0: FlexColumnWidth(1.5), // Column 0 will take twice the space of column 1
                            1: FlexColumnWidth(0.5), 
                            2: FlexColumnWidth(1), 
                            3: FlexColumnWidth(1), 
                            4: FlexColumnWidth(1), 
                          },
                          children: [
                            _buildHeaderTable(),
                          ]
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Table(
                                // border: TableBorder, // Adds borders to the table
                                columnWidths: {
                                  0: FlexColumnWidth(1.5), // Column 0 will take twice the space of column 1
                                  1: FlexColumnWidth(0.5), 
                                  2: FlexColumnWidth(1), 
                                  3: FlexColumnWidth(1), 
                                  4: FlexColumnWidth(1), 
                                },
                                children: [
                                  ...state.cartItems.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    CartItem data = entry.value;
                                    return _buildDataRow(index, data);
                                  }),
                                ]
                              ),
                            ),
                          ),
                      ),
                    Container(
                      color: AppColors.mainBlack,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Tạm tính: $total đ',
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                            ),
                            Expanded(
                              child: Container(
                                color: AppColors.mainRed,
                                child: OutlinedButton(
                                    onPressed: () {
                                      // var orderState = BlocProvider.of<OrderBloc>(context).state;
                                      // context.read<CartBloc>().add(SetTable(table: orderState.selectedTable));
                                      // Navigator.pushNamed(context, 'ConfirmPage');

                                      Navigator.of(context).push(
                                        MaterialPageRoute<ConfirmPage>(
                                          builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<OrderBloc>(context),
                                            child: const ConfirmPage(),
                                          ),
                                        ),
                                      );

                                      // String sendNewOrder = "0";
                                      // String reSendOrder = "0";
                                      // var orderState = BlocProvider.of<OrderBloc>(context).state;
                                      // String status = state.getStatus(isEdit: !orderState.isAddNew);
                                      // if (status == Order.STATUS_DATATABLE_NO_DATA) {
                                      //   ScaffoldMessenger.of(context)
                                      //   ..hideCurrentSnackBar()
                                      //   ..showSnackBar(
                                      //     SnackBar(content: Text(status)),
                                      //   );
                                      // } else {
                                      //   if (status == Order.STATUS_DATATABLE_SEND_ALL) {
                                      //     sendNewOrder = "1";
                                      //   } else if (status == Order.STATUS_DATATABLE_RESEND) {
                                      //     reSendOrder = "1"; 
                                      //     // @TODO: need to confirm modal before resend
                                      //   }
                                      //   context.read<CartBloc>().add(SendOrder(
                                      //     sendNewOrder: sendNewOrder,
                                      //     reSendOrder: reSendOrder,
                                      //     order: orderState.order,
                                      //     isAddNew: orderState.isAddNew,
                                      //     typeLoad: orderState.isAddNew ? "NewOrder" : "EditOrder",
                                      //     currTable: orderState.selectedTable.TableNo,
                                      //     currTableGroup: orderState.selectedForGroup.TableNo,
                                      //     noOfPerson: "1",
                                      //     salesCode: orderState.selectedCode.code,
                                      //     POSBizDate: ScreenUtil.getCurrentDate('yyyyMMdd')
                                      //   ));
                                      // }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide.none, // Remove the default border
                                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0), // Button padding
                                    ),
                                    child: const Text('Xác nhận', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
  
  _buildTableCellText(String text, [EdgeInsetsGeometry padding = const EdgeInsets.only(top: 15.0, bottom: 15.0)]) {
    return TableCell(
      child: Padding(
              padding: padding,
              child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
    );
  }

  _buildHeaderTable() {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Right border color
            width: 1.0, // Border width
          ),
        ),
      ),
      children: [
        _buildTableCellText('Tên món'),
        _buildTableCellText('S/L'),
        _buildTableCellText('Đơn giá'),
        _buildTableCellText('Trạng thái'),
        _buildTableCellText(''),
      ],
    );
  }

  _buildControl(int index, {hideIncrease = false}) {
    BorderRadius border = BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5));
    if (hideIncrease) {
      border = BorderRadius.all(Radius.circular(5));
    }
    return TableCell(
      child: Expanded(
        child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        border: const Border(
                          left: BorderSide(color: Colors.grey, width: 1.0),
                          top: BorderSide(color: Colors.grey, width: 1.0),
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                          right: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        borderRadius: border,
                      ),
                      child: IconButton(
                        icon: Icon(!hideIncrease ? Icons.remove : Icons.close, size: 15),
                        onPressed: () {
                          context.read<CartBloc>().add(Decrease(position: index));
                        },
                      ),
                    ),
                    !hideIncrease ? Container(
                      width: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 1.0),
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                          right: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 15),
                        onPressed: () {
                          context.read<CartBloc>().add(Increase(position: index));
                        },
                      ),
                    ) : SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }

  TableRow _buildDataRow(int index, CartItem item) {
    String title = item.item.recptDesc;
    String qty = item.qty.toString();
    String pricing = '${ScreenUtil.formatPrice(item.item.getOrgPrice())} đ';
    String status = item.item.getPrintStatusStr();
    final hideIncrease = item.item.comboPack == "C";
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Right border color
            width: 1.0, // Border width
          ),
        ),
      ),
      children: [
        _buildTableCellText(title),
        _buildTableCellText(qty),
        _buildTableCellText(pricing),
        _buildTableCellText(status, ),
        item.item.getItemType() != "M" ? _buildControl(index, hideIncrease: hideIncrease) : const TableCell(child: SizedBox()),
      ],
    );
  }
}

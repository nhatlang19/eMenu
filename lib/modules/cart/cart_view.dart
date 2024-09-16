import 'dart:io';

import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/order.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
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
          context.read<CartBloc>().add(ResetCart());
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
                            0: FlexColumnWidth(2), // Column 0 will take twice the space of column 1
                            1: FlexColumnWidth(1), 
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
                                  0: FlexColumnWidth(2), // Column 0 will take twice the space of column 1
                                  1: FlexColumnWidth(1), 
                                  2: FlexColumnWidth(1), 
                                  3: FlexColumnWidth(1), 
                                  4: FlexColumnWidth(1), 
                                },
                                children: [
                                  ...state.cartItems.map((data) => _buildDataRow(data)).toList(),
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
                                      String sendNewOrder = "0";
                                      String reSendOrder = "0";
                                      var orderState = BlocProvider.of<OrderBloc>(context).state;
                                      String status = state.getStatus(isEdit: !orderState.isAddNew);
                                      if (status == Order.STATUS_DATATABLE_NO_DATA) {
                                        ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(content: Text(status)),
                                        );
                                      } else {
                                        if (status == Order.STATUS_DATATABLE_SEND_ALL) {
                                          sendNewOrder = "1";
                                        } else if (status == Order.STATUS_DATATABLE_RESEND) {
                                          reSendOrder = "1"; 
                                          // @TODO: need to confirm modal before resend
                                        }
                                        context.read<CartBloc>().add(SendOrder(
                                          sendNewOrder: sendNewOrder,
                                          reSendOrder: reSendOrder,
                                          order: orderState.order,
                                          isAddNew: orderState.isAddNew,
                                          typeLoad: orderState.isAddNew ? "NewOrder" : "EditOrder",
                                          currTable: orderState.selectedTable.TableNo,
                                          currTableGroup: orderState.selectedForGroup.TableNo,
                                          noOfPerson: "1",
                                          salesCode: orderState.selectedCode.code,
                                          POSBizDate: ScreenUtil.getCurrentDate('yyyyMMdd')
                                        ));
                                      }
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
              child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
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
      ],
    );
  }

  TableRow _buildDataRow(CartItem item) {
    String title = item.item.recptDesc;
    String qty = item.qty.toString();
    String pricing = '${ScreenUtil.formatPrice(item.item.getOrgPrice())} đ';
    String status = item.item.getPrintStatusStr();
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
        _buildTableCellText(status),
      ],
    );
  }
}

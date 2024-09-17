import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/constants/order.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

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
          var state = context.read<OrderBloc>().state;
          context.read<CartBloc>().add(LoadItemsWhenEdit(
                            orderNo: state.order.getOrd(),
                            extNo: state.order.getExt(),
                            posNo: state.order.getPos()));

          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Column(
        children: [
          _buildBack(context),
          _buildTitle(context),
          _buildTableHeader(context),
          _buildTableRow(context),
          _buildConfirmButton(context),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  _buildBack(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios, size: 40),
                Text('Quay lại')
              ],
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          const SizedBox(
            width: 1,
          ),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Center(
          child: Text(
            'Bàn ${state.selectedTable.TableNo.trim()} | Xác nhận món đã đặt',
            style: const TextStyle(fontSize: 30),
          ),
        );
      },
    );
  }

  _buildTableRow(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 5;
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.cartItems.length != current.cartItems.length ||
          current.status == CartStatus.updatedQuantity ||
          current.status == CartStatus.success,
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: width, right: width, top: 0.0),
              child: Table(columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              }, children: [
                ...state.cartItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  CartItem data = entry.value;
                  return _buildDataRow(index, data);
                }),
              ]),
            ),
          ),
        );
      },
    );
  }

  TableRow _buildDataRow(int index, CartItem item) {
    String title = item.item.recptDesc;
    String qty = item.qty.toStringAsFixed(1);
    if (item.item.getPrintStatusStr() == "") {
      return TableRow(
        children: [
          _buildTableCellText(title,
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0)),
          _buildTableCellTextCenter(qty,
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0)),
        ],
      );
    } else {
      return const TableRow(
        children: [
          SizedBox(),
          SizedBox(),
        ],
      );
    }
  }

  _buildTableHeader(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 5;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: width, right: width, top: 8.0),
        child: Table(columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
        }, children: [
          TableRow(
            children: [
              _buildTableCellText('Tên món'),
              _buildTableCellTextCenter('Số lượng'),
            ],
          )
        ]),
      ),
    );
  }

  _buildTableCellText(String text,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 15.0, bottom: 15.0)}) {
    return TableCell(
      child: Padding(
        padding: padding,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  _buildTableCellTextCenter(String text,
      {EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 15.0, bottom: 15.0)}) {
    return Center(
      child: TableCell(
        child: Padding(
          padding: padding,
          child: Text(text, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  _buildConfirmButton(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Center(
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
                      POSBizDate: ScreenUtil.getCurrentDate('yyyyMMdd')));
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide.none, // Remove the default border
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0), // Button padding
              ),
              child: const Text('Xác nhận',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}

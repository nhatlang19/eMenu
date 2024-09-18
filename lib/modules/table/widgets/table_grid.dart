import 'package:emenu/config/themes/app_button_styles.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/table/bloc/salescode_bloc.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/widgets/bill_dropdown.dart';
import 'package:emenu/modules/table/widgets/group_dropdown.dart';
import 'package:emenu/modules/table/widgets/sales_code_dropdown.dart';
import 'package:emenu/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emenu/models/table.dart' as MyTable;

class TableGrid extends StatefulWidget {
  const TableGrid({super.key});

  @override
  State<TableGrid> createState() => _TableGridState();
}

class _TableGridState extends State<TableGrid> {
  @override
  Widget build(BuildContext buildContext) {
    final tableBloc = context.read<TableBloc>();
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.status == OrderStatus.success) {
          if (state.orders.isEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Error BizDate >> Không thể load lại order. Vui lòng kiểm tra kết ngày.')),
              );
          } else if (state.orders.length == 1) {
            var tableState = context.read<TableBloc>().state;
            var salesCodeState = context.read<SalesCodeBloc>().state;
            navigateOrder(context, tableState, salesCodeState, state, tableBloc);
          } else {
            var tableState = context.read<TableBloc>().state;
            _showSelectBillDialog(context, tableState.table);
          }
        }
      },
      child: BlocBuilder<TableBloc, TableState>(
        buildWhen: (previous, current) => (previous.status != current.status && current.status == TableStatus.success) || current.status == TableStatus.refresh,
        builder: (context, state) {
          return Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Change this for more/less columns
                      childAspectRatio:
                          ScreenUtil.isPortrait(context) ? 2 : 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.tables.length,
                    itemBuilder: (context, index) {
                      var table = state.tables[index];
                      return InkWell(
                          onTap: () {
                            doShowDialog(context, table);
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            color: table.getColor(),
                            elevation: 5,
                            child: Center(
                              child: Text(
                                table.TableNo.trim(),
                                style: AppTextStyles.tableTitle,
                              ),
                            ),
                          ));
                    },
                  )));
        },
      ),
    );
  }

  void doShowDialog(BuildContext parentContext, MyTable.Table table) {
    var openBy = table.OpenBy.toString();
    switch (table.Status) {
      case "A":
      case "B":
        if (table.openByIsEmpty()) {
          // @TODO: updateTableStatus (xem TableAdapter.java:101)
          parentContext.read<TableBloc>().add(SelectTable(isAddNew: true, table: table));
          _showCustomDialog(parentContext, table, isAddNew: true);
        } else {
          ScaffoldMessenger.of(parentContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                      'Bàn ${table.TableNo.trim()} đang được order bởi cashier ${openBy.trim()}')),
            );
        }
        break;
      case "O":
        if (table.openByIsEmpty()) {
          // @TODO: updateTableStatus (xem TableAdapter.java:101)
          parentContext.read<TableBloc>().add(SelectTable(isAddNew: false, table: table));
          _showCustomDialog(parentContext, table, isAddNew: false);
        } else {
          ScaffoldMessenger.of(parentContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                      'Bàn ${table.TableNo.trim()} đang được order bởi cashier $openBy')),
            );
        }
        break;
      case "R":
      default:
        break;
    }
  }

  void _showSelectBillDialog(BuildContext parentContext, MyTable.Table table) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // Custom width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Bill', style: AppTextStyles.dialogTitle),
                const SizedBox(height: 16),
                BlocProvider.value(
                    value: BlocProvider.of<OrderBloc>(parentContext),
                    child: const BillDropdown()),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          var tableState = parentContext.read<TableBloc>().state;
                          var salesCodeState = parentContext.read<SalesCodeBloc>().state;
                          var orderState = parentContext.read<OrderBloc>().state;
                          var tableBloc = parentContext.read<TableBloc>();
                          navigateOrder(context, tableState, salesCodeState, orderState, tableBloc);
                        },
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCustomDialog(BuildContext parentContext, MyTable.Table table,
      {isAddNew = false}) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // Custom width
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Table: ${table.TableNo.trim()} => ${!isAddNew ? "Edit Order" : "New Order"}',
                  style: AppTextStyles.dialogTitle,
                ),
                const SizedBox(height: 16),
                BlocProvider.value(
                    value: BlocProvider.of<TableBloc>(parentContext),
                    child: const GroupDropdown()),
                BlocProvider.value(
                    value: BlocProvider.of<SalesCodeBloc>(parentContext),
                    child: const SalesCodeDropdown()),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: !isAddNew
                            ? AppButtonStyles.btnSaveEnabled
                            : AppButtonStyles.btnSaveDisabled,
                        onPressed: () {
                          if (!isAddNew) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
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
                          var tableState =
                              parentContext.read<TableBloc>().state;
                          if (isAddNew) {
                            Navigator.of(context).pop();
                            var salesCodeState = parentContext.read<SalesCodeBloc>().state;
                            var orderState = parentContext.read<OrderBloc>().state;
                            var tableBloc = parentContext.read<TableBloc>();
                            navigateOrder(context, tableState, salesCodeState, orderState, tableBloc);
                          } else {
                            var posBizDate = ScreenUtil.getCurrentDate('yyyyMMdd');
                            parentContext.read<OrderBloc>().add(FetchOrders(posBizDate: posBizDate,currentTable: tableState.table.TableNo));
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> navigateOrder(context, tableState, salesCodeState, orderState, tableBloc) async {
    final result = await Navigator.pushNamed(context, 'OrderPage',
        arguments: <String, dynamic>{
          "tableGroup": tableState.selectedForGroup,
          "tableStatus": tableState.isAddNew,
          "selectedTable": tableState.table,
          "selectedCode": salesCodeState.selectedCode,
          "tableSection": tableState.currentSection,
          "order": orderState.order
        });

    if (result != null) {
      if  (result == "REFRESH_TABLE") {
        tableBloc.add(const RefreshFetchTable());
      }
    }
  }
}

import 'package:emenu/config/themes/app_button_styles.dart';
import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/table/bloc/salescode_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/widgets/group_dropdown.dart';
import 'package:emenu/modules/table/widgets/sales_code_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emenu/models/table.dart' as MyTable;

class TableGrid extends StatelessWidget {
  const TableGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Expanded(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Change this for more/less columns
                    childAspectRatio: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
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
    );
  }

  void doShowDialog(BuildContext parentContext, MyTable.Table table) {
    var openBy = table.OpenBy.toString();
    switch (table.Status) {
      case "A":
      case "B":
        if (table.openByIsEmpty()) {
          // @TODO: updateTableStatus (xem TableAdapter.java:101)
          parentContext.read<TableBloc>().add(ChangeIsAddNew(isAddNew: true));
          _showCustomDialog(parentContext, table);
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
          parentContext.read<TableBloc>().add(ChangeIsAddNew(isAddNew: false));
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
            width: MediaQuery.of(context).size.width * 0.8, // Custom width
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
                          Navigator.of(context).pop();
                          var tableState = parentContext.read<TableBloc>().state;
                          var salesCodeState = parentContext.read<SalesCodeBloc>().state;
                          Navigator.pushNamed(context, 'OrderPage', arguments: <String, dynamic>{
                            "tableGroup": tableState.selectedForGroup,
                            "tableStatus": tableState.isAddNew,
                            "selectedTable": tableState.table,
                            "selectedCode": salesCodeState.selectedCode
                          });
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
}

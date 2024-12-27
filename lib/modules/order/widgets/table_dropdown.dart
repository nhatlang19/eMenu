import 'package:emenu/modules/order/bloc/order_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emenu/models/table.dart' as my_table;

class TableDropdown extends StatefulWidget {
  const TableDropdown({super.key});

  @override
  State<TableDropdown> createState() => _TableDropdownState();
}

class _TableDropdownState extends State<TableDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      // buildWhen: (previous, current) => previous.selectedForGroup.TableNo != current.selectedForGroup.TableNo,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Bàn: ',
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
                          child: DropdownButton<my_table.Table>(
                        value: state.moveTable.TableNo == '' ? null : state.moveTable,
                        onChanged: (my_table.Table? newValue) {
                          context.read<OrderBloc>().add(ChangeSelectedTable(table: newValue ?? state.selectedTable));
                        },
                        items: state.tableAllSection.map<DropdownMenuItem<my_table.Table>>((my_table.Table table) {
                          return DropdownMenuItem<my_table.Table>(
                            value: table,
                            child: Text(table.TableNo ?? ''),
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

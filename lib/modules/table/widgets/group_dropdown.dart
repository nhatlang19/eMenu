import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emenu/models/table.dart' as MyTable;

class GroupDropdown extends StatelessWidget {
  const GroupDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      buildWhen: (previous, current) =>
          previous.selectedForGroup.TableNo != current.selectedForGroup.TableNo,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'Group: ',
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
                          child: DropdownButton<MyTable.Table>(
                        value: state.selectedForGroup.TableNo == '' ? null : state.selectedForGroup,
                        onChanged: (MyTable.Table? newValue) {
                          context.read<TableBloc>().add(ChangeSelectGroup(group: newValue ?? state.selectedForGroup));
                        },
                        items: state.tables.map<DropdownMenuItem<MyTable.Table>>((MyTable.Table table) {
                          return DropdownMenuItem<MyTable.Table>(
                            value: table,
                            child: Text(table.TableNo),
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

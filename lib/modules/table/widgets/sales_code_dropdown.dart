import 'package:emenu/models/sales_code.dart';
import 'package:emenu/modules/table/bloc/salescode_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emenu/models/table.dart' as MyTable;

class SalesCodeDropdown extends StatelessWidget {
  const SalesCodeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesCodeBloc, SalesCodeState>(
      buildWhen: (previous, current) =>
          previous.selectedCode.code != current.selectedCode.code,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Text(
                      'SalesCode: ',
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<SalesCode>(
                        value: state.selectedCode,
                        onChanged: (SalesCode? newValue) {
                          context.read<SalesCodeBloc>().add(ChangeSelectSalesCode(code: newValue ?? state.selectedCode));
                        },
                        items: state.salescodes
                            .map<DropdownMenuItem<SalesCode>>((SalesCode code) {
                          return DropdownMenuItem<SalesCode>(
                            value: code,
                            child: Text(code.description ?? 'N/A'),
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

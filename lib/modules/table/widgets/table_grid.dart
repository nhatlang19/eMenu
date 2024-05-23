import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          Navigator.pushNamed(context, 'OrderPage');
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
                              table.TableNo,
                              style: AppTextStyles.tableTitle,
                            ),
                          ),
                        ));
                  },
                )));
      },
    );
  }
}

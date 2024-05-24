import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/bloc/user_bloc.dart';
import 'package:emenu/modules/table/widgets/cashier_dropdown.dart';
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
                          _showCustomDialog(context);
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

  void _showCustomDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<UserBloc>(parentContext),
          child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Custom width
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Custom Width Dialog',
                      style: AppTextStyles.dialogTitle,
                    ),
                    SizedBox(height: 16),
                    CashierDropdown(),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, 'OrderPage');
                          },
                          child: Text('OK'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
        ));
      },
    );
  }
}
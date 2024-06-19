import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/widgets/section_filter.dart';
import 'package:emenu/modules/table/widgets/table_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<SectionBloc, SectionState>(
            listener: (context, state) {
              if (state.status == SectionStatus.success) {
                context
                    .read<TableBloc>()
                    .add(FetchTable(section: state.sections.first.section));
              }
            },
          ),
          // BlocListener<TableBloc, TableState>(
          //   listener: (context, state) {
          //     // @TODO: not implemented yet
          //   },

          // ),
          // BlocListener<UserBloc, UserState>(
          //   listener: (context, state) {
          //   },
          // ),
        ],
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: SectionFilter()),
                InkWell(
                  onTap: () {
                    
                  },
                  splashColor: Colors.blue, // splash color on tap
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                          BorderRadius.circular(8), // button border radius
                      color: Colors.blueAccent, // button background color
                    ),
                    child: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.red, // splash color on tap
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius:
                          BorderRadius.circular(8), // button border radius
                      color: Colors.redAccent, // button background color
                    ),
                    child: Text(
                      'Exit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            TableGrid()
          ],
        ));
  }
}

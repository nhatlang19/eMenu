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
        ],
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(flex: 2,child: SectionFilter()),
                Expanded(flex: 1,
                  child: InkWell(
                    onTap: () {
                      var sectionState = context.read<SectionBloc>().state;
                      context.read<TableBloc>().add(FetchTable(section: sectionState.sections.first.section));
                    },
                    splashColor: Colors.blue, // splash color on tap
                    child: Container(
                      padding: EdgeInsets.only(bottom: 14, top: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius:
                            BorderRadius.circular(8), // button border radius
                        color: Colors.blueAccent, // button background color
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Refresh',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    splashColor: Colors.red, // splash color on tap
                    child: Container(
                      padding: EdgeInsets.only(bottom: 14, top: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius:
                            BorderRadius.circular(8), // button border radius
                        color: Colors.redAccent, // button background color
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Exit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
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

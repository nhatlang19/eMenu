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
              context.read<TableBloc>().add(FetchTable(section: state.sections.first.section));
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
      child: const Column(
        children: [
          SectionFilter(),
          TableGrid()
        ],
      )
    );
  }
}
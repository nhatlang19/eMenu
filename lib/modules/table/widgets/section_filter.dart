import 'package:emenu/models/section.dart';
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionFilter extends StatelessWidget {
  const SectionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionBloc, SectionState>(
      buildWhen: (previous, current) => previous.section != current.section,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
             child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: DropdownButtonHideUnderline(
                child:DropdownButton<String>(
              value: state.section,
              onChanged: (String? newValue) {
                // state.copyWith(section: newValue);
                context.read<TableBloc>().add(FetchTable(section: newValue ?? state.sections.first.section));
                context.read<SectionBloc>().add(ChangeSection(section: newValue ?? state.sections.first.section));
              },
              items: state.sections.map<DropdownMenuItem<String>>((Section section) {
                return DropdownMenuItem<String>(
                  value: section.section,
                  child: Text(section.description1),
                );
              }).toList(),
             )))
        );
      },
    );
  }
}
import 'package:emenu/modules/table/bloc/section_bloc.dart';
import 'package:emenu/modules/table/bloc/table_bloc.dart';
import 'package:emenu/modules/table/bloc/user_bloc.dart';
import 'package:emenu/modules/table/widgets/table_view.dart';
import 'package:emenu/repositories/section_repository.dart';
import 'package:emenu/repositories/table_repository.dart';
import 'package:emenu/repositories/user_repository.dart';
import 'package:emenu/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  late final SectionRepository sectionRepository;
  late final TableRepository tableRepository;
  late final UserRepository userRepository;

   @override
  void initState() {
    super.initState();
    sectionRepository = SectionRepository();
    tableRepository = TableRepository();
    userRepository = UserRepository();
  }

  Future<String> _getSettings() async {
    var settings = Settings();
    var setting = await settings.read();
    return setting.section;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: const Text('Table'),
          ),
          body: FutureBuilder<String>(
            future: _getSettings(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
               if (snapshot.hasData) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<SectionBloc>(
                        create: (BuildContext context) => SectionBloc(sectionRepository: sectionRepository)..add(FetchSection(section: '${snapshot.data}')),
                      ),
                      BlocProvider<TableBloc>(
                        create: (BuildContext context) => TableBloc(tableRepository: tableRepository),
                      ),
                      BlocProvider<UserBloc>(
                        create: (BuildContext context) => UserBloc(userRepository: userRepository)..add(const FetchUsers()),
                      ),
                    ],
                    child: const TableView()
                  );
               }
               return const Center(child: Text('null'));
            }
          ),
          
    );
  }
}

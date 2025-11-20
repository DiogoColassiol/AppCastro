// ignore_for_file: file_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/card_teses_widget.dart';

class ListTesesScreen extends StatefulWidget {
  const ListTesesScreen({super.key});

  @override
  State<ListTesesScreen> createState() => _ListTesesScreenState();
}

class _ListTesesScreenState extends State<ListTesesScreen> {
  List<Tese> _listTese = [];
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    final cubit = context.read<ProjectCubit>();
    if (cubit.state.teses == null) {
      final list = await cubit.getlistTese();
      setState(() {
        _listTese = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.surfaceColor,
      // floatingActionButton: CustomFloatButton(p
      //   alignment: MainAxisAlignment.end,
      //   buttons: [
      //     FloatButton(
      //       label: 'Adicionar Tese',
      //       icon: Icons.add,
      //       backgroundColor: ThemeUtils.primaryColor,
      //       foregroundColor: Colors.white,
      //       onPressed: () async {
      //         await TeseDialog.show(context);
      //       },
      //     ),
      //   ],
      // ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          final cubit = context.read<ProjectCubit>();
          return Container(
            color: ThemeUtils.surfaceColor,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: cubit.state.teses!.length,
                  itemBuilder: (context, index) {
                    final tese = cubit.state.teses![index];
                    return CardTeses(
                      tese: tese,
                      isLarge: true,
                    );
                  },
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}

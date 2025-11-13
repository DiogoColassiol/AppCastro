// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/repositories/tesesDAO.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/card_teses_widget.dart';

class ListTesesScreen extends StatefulWidget {
  const ListTesesScreen({super.key});

  @override
  State<ListTesesScreen> createState() => _ListTesesScreenState();
}

class _ListTesesScreenState extends State<ListTesesScreen> {
  late Future<List<Tese>> _listTeses;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProjectCubit>();
    _listTeses = cubit.getlistTese();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.surfaceColor,
      // floatingActionButton: CustomFloatButton(
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
          return Container(
            color: ThemeUtils.surfaceColor,
            child: Column(
              children: [
                FutureBuilder(
                    future: _listTeses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Erro: ${snapshot.error}');
                      } else {
                        final teses = snapshot.data ?? [];
                        return Expanded(
                          child: ListView.builder(
                            itemCount: teses.length,
                            itemBuilder: (context, index) {
                              final tese = teses[index];
                              return CardTeses(
                                tese: tese,
                                isLarge: true,
                              );
                            },
                          ),
                        );
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/repositories/tesesDAO.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/card_teses_widget.dart';
import 'package:project/widgets/dialogs/teseDialog.dart';
import 'package:project/widgets/floatButton.dart';

class ListTesesScreen extends StatelessWidget {
  const ListTesesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tesesRepo = context.watch<TesesDAO>();
    return Scaffold(
      backgroundColor: ThemeUtils.surfaceColor,
      floatingActionButton: CustomFloatButton(
        alignment: MainAxisAlignment.end,
        buttons: [
          FloatButton(
            label: 'Adicionar Tese',
            icon: Icons.add,
            backgroundColor: ThemeUtils.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              await TeseDialog.show(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          return Container(
            color: ThemeUtils.surfaceColor,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: tesesRepo.tesesList.length,
                  itemBuilder: (context, index) {
                    final tese = tesesRepo.tesesList[index];
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

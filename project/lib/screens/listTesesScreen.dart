import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/repositories/tesesDAO.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/card_teses_widget.dart';

class ListTesesScreen extends StatelessWidget {
  const ListTesesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tesesRepo = context.watch<TesesDAO>();

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Container(
          color: ThemeUtils.surfaceColor,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: tesesRepo.tesesList.length,
                itemBuilder: (context, index) {
                  final teses = tesesRepo.tesesList[index];
                  return CardTeses(
                    id: teses.id.toString(),
                    desc: teses.descricao,
                    docsRequeridos: teses.legenda,
                    isLarge: true,
                  );
                },
              )),
            ],
          ),
        );
      },
    );
  }
}

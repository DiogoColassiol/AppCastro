// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/dialogs/deleteSegDialog.dart';
import 'package:project/widgets/dialogs/segmentoDialog.dart';
import 'package:project/utils/theme_utils.dart';

class SegmentosScreen extends StatelessWidget {
  const SegmentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbCubit, DbState>(builder: (context, state) {
      return Container(
        color: ThemeUtils.surfaceColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.listSegmentos == null
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: _cardSegs(context),
                  ),
            Container(
              color: ThemeUtils.surfaceColor,
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buttonAdd(context)],
              ),
            ),
          ],
        ),
      );
    });
  }

  _cardSegs(BuildContext context) {
    final cubit = context.read<DbCubit>();
    final segmentos = cubit.state.listSegmentos!
        .where((seg) => seg.nome != 'Outros')
        .toList();

    return ListView.builder(
      itemCount: segmentos.length,
      itemBuilder: (context, index) {
        final seg = segmentos[index];
        return Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(children: [
                    IconButton(
                      onPressed: () async {
                        await SegmentoDeleteDialog.show(seg, context);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ]),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              seg.nome ?? 'Sem nome',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )
                          ],
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buttonAdd(BuildContext context) {
    return ButtonApp(
        text: 'Adicionar Segmento',
        color: ThemeUtils.primaryColor,
        onPressed: () async {
          await SegmentoDialog.show(context);
        });
  }
}

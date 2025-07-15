import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/repositories/segmentoDAO.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/segmentoDialog.dart';
import 'package:provider/provider.dart';
import 'package:project/utils/theme_utils.dart';

class SegmentosScreen extends StatelessWidget {
  const SegmentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final segmentoRepo = context.watch<SegmentoDAO>();
    return BlocBuilder<DbCubit, DbState>(builder: (context, state) {
      return Container(
        color: ThemeUtils.surfaceColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            segmentoRepo.segmentosList.isEmpty
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: segmentoRepo.segmentosList.length,
                      itemBuilder: (context, index) {
                        final seg = segmentoRepo.segmentosList[index];
                        return ListTile(
                          title: Text(seg.nome ?? 'Sem nome'),
                        );
                      },
                    ),
                  ),
            ButtonApp(
                text: 'Editar',
                color: Colors.purple,
                onPressed: () async {
                  await SegmentoDialog.show(context);
                })
          ],
        ),
      );
    });
  }
}

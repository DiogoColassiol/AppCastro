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
      final segmentos =
          segmentoRepo.segmentosList.where((s) => s.nome != 'Outros').toList();
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
                      itemCount: segmentos.length,
                      itemBuilder: (context, index) {
                        final seg = segmentos[index];
                        return Card(
                          child: ListTile(
                            title: Text(seg.nome ?? 'Sem nome'),
                            subtitle: Text(seg.numTeses ?? ''),
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
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

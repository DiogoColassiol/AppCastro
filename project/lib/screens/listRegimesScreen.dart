import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/repositories/regimeRepo.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/regimesDialog.dart';

class RegimesScreen extends StatefulWidget {
  const RegimesScreen({super.key});

  @override
  State<RegimesScreen> createState() => _ListRegimesScreenState();
}

class _ListRegimesScreenState extends State<RegimesScreen> {
  @override
  Widget build(BuildContext context) {
    final regimeRepo = context.watch<RegimeDAO>();
    return BlocBuilder<DbCubit, DbState>(builder: (context, state) {
      return Container(
        color: ThemeUtils.surfaceColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            regimeRepo.regimesList.isEmpty
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: regimeRepo.regimesList.length,
                      itemBuilder: (context, index) {
                        final doc = regimeRepo.regimesList[index];
                        return ListTile(
                          title: Text(doc.documento.nome ?? 'Sem nome'),
                        );
                      },
                    ),
                  ),
            ButtonApp(
                text: 'Editar',
                color: Colors.purple,
                onPressed: () async {
                  await RegimeDialog.show(context);
                })
          ],
        ),
      );
    });
  }
}

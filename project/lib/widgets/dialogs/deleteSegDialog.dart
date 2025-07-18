import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_sec_widget.dart';

class SegmentoDeleteDialog {
  static Future<void> show(BuildContext context) async {
    final cubit = context.read<DbCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DbCubit>.value(
            value: cubit, child: const SegDeleteBuildDialog());
      },
    );
  }
}

class SegDeleteBuildDialog extends StatefulWidget {
  const SegDeleteBuildDialog({super.key});

  @override
  State<SegDeleteBuildDialog> createState() => _SegDeleteBuildDialogState();
}

class _SegDeleteBuildDialogState extends State<SegDeleteBuildDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.surfaceColor,
      title: const Text('Excluir Segmento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(child: _content(context)),
      actions: [_buttonSair(context), _buttonConfirm(context)],
    );
  }

  _content(BuildContext context) {
    return const Text('Tem certeza que deseja excluir este segmento?');
  }

  Widget _buttonSair(BuildContext context) {
    //   final cubit = context.read<DbCubit>();
    return ButtonSec(
      label: 'Sair',
      labelColor: ThemeUtils.primaryColor,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonConfirm(BuildContext context) {
    //   final cubit = context.read<DbCubit>();
    return ButtonSec(
      label: 'Excluir',
      labelColor: Colors.white,
      buttonColor: ThemeUtils.accentError,
      onPressed: () async {},
    );
  }
}

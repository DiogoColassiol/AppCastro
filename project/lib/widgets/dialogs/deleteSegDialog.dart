// ignore_for_file: must_be_immutable, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_sec_widget.dart';

class SegmentoDeleteDialog {
  static Future<void> show(Segmento seg, BuildContext context) async {
    final cubit = context.read<ProjectCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<ProjectCubit>.value(
            value: cubit, child: SegDeleteBuildDialog(segmento: seg));
      },
    );
  }
}

class SegDeleteBuildDialog extends StatefulWidget {
  Segmento segmento;
  SegDeleteBuildDialog({super.key, required this.segmento});

  @override
  State<SegDeleteBuildDialog> createState() => _SegDeleteBuildDialogState();
}

class _SegDeleteBuildDialogState extends State<SegDeleteBuildDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.surfaceColor,
      title: const Text('Excluir Segmento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(child: _content(context)),
      actions: [
        _buttonSair(context),
        _buttonConfirm(context),
      ],
    );
  }

  _content(BuildContext context) {
    return const Text('Tem certeza que deseja excluir este segmento?');
  }

  Widget _buttonSair(BuildContext context) {
    return ButtonSec(
      label: 'Sair',
      labelColor: ThemeUtils.primaryColor,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonConfirm(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return ButtonSec(
      label: 'Excluir',
      labelColor: Colors.white,
      buttonColor: ThemeUtils.accentError,
      onPressed: () async {
        await cubit.deleteSegmento(widget.segmento);
        Navigator.pop(context);
      },
    );
  }
}

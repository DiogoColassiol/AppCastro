import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/input_widget.dart';

class RegimeDialog {
  static Future<void> show(BuildContext context) async {
    final cubit = context.read<ProjectCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<ProjectCubit>.value(
            value: cubit, child: const RegimeBuildDialog());
      },
    );
  }
}

class RegimeBuildDialog extends StatefulWidget {
  const RegimeBuildDialog({super.key});

  @override
  State<RegimeBuildDialog> createState() => _RegimeBuildDialogState();
}

class _RegimeBuildDialogState extends State<RegimeBuildDialog> {
  late TextEditingController _newId;
  late TextEditingController _newNome;

  @override
  void initState() {
    super.initState();
    _newId = TextEditingController();
    _newNome = TextEditingController();
  }

  @override
  void dispose() {
    _newId.dispose();
    _newId.text = '';
    _newNome.dispose();
    _newNome.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.backgroundColor,
      title: const Text(
        'Regime',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: _buildContent(context),
      actions: [_buttonSair(context)],
    );
  }

  _buildContent(BuildContext context) {
    return _content(context);
  }

  _content(BuildContext context) {
    final cubit = context.read<DbCubit>();
    return BlocBuilder<DbCubit, DbState>(builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Input(
                  label: 'ID',
                  //   value: state.regimeId,
                  controller: _newId,
                  onChanged: (value) {
                    //        cubit.setRegimeID(value);
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Input(
                  label: 'Nome',
                  //       value: state.regimeNome,
                  controller: _newNome,
                  onChanged: (value) {
                    //        cubit.setRegimeNome(value);
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ButtonApp(
                  text: 'Adicionar',
                  color: ThemeUtils.primaryColor,
                  onPressed: () async {
                    //      await cubit.addRegime(context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ButtonApp(
                  text: 'Remover',
                  color: ThemeUtils.accentError,
                  onPressed: () async {
                    //   await cubit.removeRegime(context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )
        ],
      );
    });
  }

  _buttonSair(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 40),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text('Sair',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
    );
  }
}

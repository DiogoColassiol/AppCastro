import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/enum/teseTypeEnum.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_sec_widget.dart';
import 'package:project/widgets/dropDown_widget.dart';
import 'package:project/widgets/input_widget.dart';

class TeseDialog {
  static Future<void> show(BuildContext context, {Tese? tese}) async {
    final cubit = context.read<DbCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DbCubit>.value(
          value: cubit,
          child: const TesesBuildDialog(),
        );
      },
    );
  }
}

class TesesBuildDialog extends StatefulWidget {
  final Tese? tese;
  const TesesBuildDialog({super.key, this.tese});

  @override
  State<TesesBuildDialog> createState() => _TesesBuildDialogState();
}

class _TesesBuildDialogState extends State<TesesBuildDialog> {
  late TextEditingController _inputTitle;
  late TextEditingController _inputLegenda;
  final Set<String> _documentosSelecionados = {};
  TeseTypeEnum? _tipoSelecionado;

  @override
  void initState() {
    super.initState();
    _inputTitle = TextEditingController();
    _inputLegenda = TextEditingController();
    _tipoSelecionado = null;
  }

  @override
  void dispose() {
    _inputTitle.dispose();
    _inputLegenda.dispose();
    super.dispose();
  }

  final List<String> _documentos = [
    "Certificado Digital",
    "DRE",
    "Balanço",
    "Balancete",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: ThemeUtils.surfaceColor,
      title: const Text(
        'Adicionar Tese',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(child: content(context)),
      actions: [_buttonSair(context), _buttonAdd(context)],
    );
  }

  Widget content(BuildContext context) {
    final cubit = context.read<DbCubit>();
    return BlocBuilder<DbCubit, DbState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Informe os campos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Input(
                    minLines: 10,
                    label: 'Título da Tese',
                    controller: _inputTitle,
                    onChanged: (value) async {
                      cubit.setTeseDesc(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: CustomDropdown<TeseTypeEnum>(
                    label: "Tipo",
                    value: _tipoSelecionado,
                    items: TeseTypeEnum.values,
                    itemLabel: (tipo) =>
                        tipo.name[0].toUpperCase() + tipo.name.substring(1),
                    itemIcon: (tipo) {
                      switch (tipo) {
                        case TeseTypeEnum.adminstrativo:
                          return const Icon(Icons.account_balance);
                        case TeseTypeEnum.judicial:
                          return const Icon(Icons.gavel);
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _tipoSelecionado = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Input(
                    label: 'Legenda da Tese',
                    controller: _inputLegenda,
                    onChanged: (value) async {
                      cubit.setTeseLegenda(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              children: [
                Expanded(
                  child: Text("Documentos necessários",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
                width: 650,
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _documentos.map((doc) {
                      final selecionado = _documentosSelecionados.contains(doc);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (selecionado) {
                              _documentosSelecionados.remove(doc);
                            } else {
                              _documentosSelecionados.add(doc);
                            }
                          });
                        },
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  activeColor: ThemeUtils.primaryColor,
                                  value: selecionado,
                                  onChanged: (checked) {
                                    setState(() {
                                      if (checked == true) {
                                        _documentosSelecionados.add(doc);
                                      } else {
                                        _documentosSelecionados.remove(doc);
                                      }
                                    });
                                  },
                                ),
                                Text(doc),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ))
          ],
        ),
      );
    });
  }

  Widget _buttonSair(BuildContext context) {
    final cubit = context.read<DbCubit>();
    return ButtonSec(
      label: 'Sair',
      labelColor: Colors.red,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonAdd(BuildContext context) {
    final cubit = context.read<DbCubit>();
    return ButtonSec(
      label: 'Salvar',
      buttonColor: ThemeUtils.primaryColor,
      labelColor: Colors.white,
      onPressed: () async {
        await cubit.addTese(_tipoSelecionado, _documentosSelecionados);

        await cubit.setTeseDesc('');
        await cubit.setTeseLegenda('');
      },
    );
  }
}

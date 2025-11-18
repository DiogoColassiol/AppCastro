// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/card_teses_widget.dart';
import 'package:project/widgets/dialogs/alertDialogApp.dart';
import 'package:project/widgets/button_sec_widget.dart';
import 'package:project/widgets/input_widget.dart';

class SegmentoDialog {
  static Future<void> show(BuildContext context, {Segmento? seg}) async {
    final cubit = context.read<ProjectCubit>();
    if (seg != null) {
      await cubit.setSegmentoEdit(seg);
    }
    return await showDialog(
      context: context,
      builder: (context) {
        return SegmentosBuildDialog(seg: seg);
      },
    );
  }
}

class SegmentosBuildDialog extends StatefulWidget {
  final Segmento? seg;

  const SegmentosBuildDialog({super.key, this.seg});

  @override
  State<SegmentosBuildDialog> createState() => _SegmentosBuildDialogState();
}

class _SegmentosBuildDialogState extends State<SegmentosBuildDialog>
    with SingleTickerProviderStateMixin {
  late TextEditingController _inputControler;
  late TabController _tabController;
  List<Tese>? _listTeses = [];

  final Map<int, Set<int>> _selectedTesesPorDocumento = {
    1: {},
    2: {},
    3: {},
  };

  @override
  void initState() {
    super.initState();

    _inputControler = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);

    final cubit = context.read<ProjectCubit>();

    if (widget.seg == null) {
      _listTeses = cubit.state.teses;
    } else {
      final seg = widget.seg!;
      _inputControler.text = seg.nome ?? '';
      cubit.setSegmentoNome(seg.nome ?? '');

      final Map<int, Set<int>> parsed = {
        1: {},
        2: {},
        3: {},
      };

      if (seg.numTeses is String) {
        final decoded = jsonDecode(seg.numTeses!) as Map<String, dynamic>;
        decoded.forEach((docIdStr, teseIdsStr) {
          final docId = int.tryParse(docIdStr);
          if (docId != null && teseIdsStr is String) {
            parsed[docId] = teseIdsStr
                .split(',')
                .map((e) => int.tryParse(e))
                .whereType<int>()
                .toSet();
          }
        });
      }
      _selectedTesesPorDocumento.addAll(parsed);
    }
  }

  @override
  void dispose() {
    _inputControler.clear();
    _inputControler.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.surfaceColor,
      title: Text(
        widget.seg != null ? 'Editar Segmento' : 'Salvar Segmento',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(child: _content(context)),
      actions: [_buttonSair(context), _buttonAdd(context)],
    );
  }

  Widget _content(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione as teses que se enquadram ao novo segmento nos 3 regimes tributários.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Input(
              label: 'Nome do segmento',
              value: state.segmentoNome,
              controller: _inputControler,
              onChanged: (value) {
                cubit.setSegmentoNome(value);
              },
            ),
            TabBar(
              controller: _tabController,
              labelColor: ThemeUtils.primaryColor,
              indicatorColor: ThemeUtils.primaryColor,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: _tabTitle(1, 'Simples Nacional')),
                Tab(text: _tabTitle(2, 'Lucro Presumido')),
                Tab(text: _tabTitle(3, 'Lucro Real')),
              ],
            ),
            SizedBox(
              height: 250,
              width: 600,
              child: TabBarView(
                controller: _tabController,
                children:
                    [1, 2, 3].map((docId) => _buildTeseList(docId)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  String _tabTitle(int docId, String label) {
    final count = _selectedTesesPorDocumento[docId]?.length ?? 0;
    return '$label ($count)';
  }

  Widget _buildTeseList(int documentoId) {
    return ListView.builder(
      itemCount: _listTeses!.length,
      itemBuilder: (context, index) {
        final tese = _listTeses![index];
        final isSelected =
            _selectedTesesPorDocumento[documentoId]!.contains(tese.id!);
        return CardTeses(
          tese: tese,
          isLarge: false,
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedTesesPorDocumento[documentoId]!.add(tese.id!);
              } else {
                _selectedTesesPorDocumento[documentoId]!.remove((tese.id!));
              }
            });
          },
        );
      },
    );
  }

  Widget _buttonSair(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return ButtonSec(
      label: 'Sair',
      labelColor: Colors.red,
      onPressed: () async {
        await cubit.setSegmentoNome('');
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonAdd(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return ButtonSec(
      label: 'Salvar',
      buttonColor: ThemeUtils.primaryColor,
      labelColor: Colors.white,
      onPressed: () async {
        final result =
            await cubit.trataErrosEditSeg(_selectedTesesPorDocumento);
        if (result.hasError) {
          DialogApp.warning(
              context, 'Erro ao salvar novo segmento!', result.message);
          return;
        }
        if (widget.seg == null) {
          await cubit.addSegmentoComTeses(
            numTesesJson: _selectedTesesPorDocumento,
          );
          await cubit.setSegmentoNome('');
        } else {
          await cubit.updateSegmentoComTeses(
              numTesesJson: _selectedTesesPorDocumento, seg: widget.seg);
        }

        await cubit.setSegmentoNome('');
        Navigator.pop(context);
      },
    );
  }
}

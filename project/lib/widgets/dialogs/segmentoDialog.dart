// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/repositories/tesesDAO.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/dialogs/alertDialogApp.dart';
import 'package:project/widgets/button_sec_widget.dart';
import 'package:project/widgets/card_teses_widget.dart';
import 'package:project/widgets/input_widget.dart';

class SegmentoDialog {
  static Future<void> show(BuildContext context) async {
    final cubit = context.read<DbCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DbCubit>.value(
            value: cubit, child: const SegmentosBuildDialog());
      },
    );
  }
}

class SegmentosBuildDialog extends StatefulWidget {
  const SegmentosBuildDialog({super.key});

  @override
  State<SegmentosBuildDialog> createState() => _SegmentosBuildDialogState();
}

class _SegmentosBuildDialogState extends State<SegmentosBuildDialog>
    with SingleTickerProviderStateMixin {
  late TextEditingController _inputControler;
  late TabController _tabController;

//  final List<Tese> teses = loadTesesDefault();
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
      title: const Text('Salvar Segmento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(child: _content(context)),
      actions: [_buttonSair(context), _buttonAdd(context)],
    );
  }

  Widget _content(BuildContext context) {
    final cubit = context.read<DbCubit>();
    return BlocBuilder<DbCubit, DbState>(
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
              tabs: const [
                Tab(text: 'Simples Nacional'),
                Tab(text: 'Lucro Presumido'),
                Tab(text: 'Lucro Real'),
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

  Widget _buildTeseList(int documentoId) {
    final tesesRepo = context.watch<TesesDAO>();

    return ListView.builder(
      itemCount: tesesRepo.tesesList.length,
      itemBuilder: (context, index) {
        final tese = tesesRepo.tesesList[index];
        final isSelected =
            _selectedTesesPorDocumento[documentoId]!.contains(tese.id!);
        return CardTeses(
          id: tese.id.toString(),
          desc: tese.descricao,
          docsRequeridos: tese.documentos,
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
    final cubit = context.read<DbCubit>();
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
    final cubit = context.read<DbCubit>();
    return ButtonSec(
      label: 'Salvar',
      buttonColor: ThemeUtils.primaryColor,
      labelColor: Colors.white,
      onPressed: () async {
        final result = await cubit.trataErros(_selectedTesesPorDocumento);
        if (result.hasError) {
          DialogApp.warning(
              context, 'Erro ao salvar novo segmento!', result.message);
          return;
        }
        await cubit.addSegmentoComTeses(
          numTesesJson: _selectedTesesPorDocumento,
        );
        await cubit.setSegmentoNome('');
        Navigator.pop(context);
      },
    );
  }
}

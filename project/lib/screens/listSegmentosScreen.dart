// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/widgets/button_sec_widget.dart';
import 'package:project/widgets/card_teses_widget.dart';
import 'package:project/widgets/dialogs/deleteSegDialog.dart';
import 'package:project/widgets/dialogs/segmentoDialog.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/floatButton.dart';

class SegmentosScreen extends StatefulWidget {
  const SegmentosScreen({super.key});

  @override
  State<SegmentosScreen> createState() => _SegmentosScreenState();
}

class _SegmentosScreenState extends State<SegmentosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Segmento> _listSegmentos = [];
  List<Tese> _listTeses = [];

  final Map<int, Set<int>> _tesesDoSegmento = {
    1: {},
    2: {},
    3: {},
  };

  @override
  void initState() {
    super.initState();
    _loadData();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _loadData() async {
    final cubit = context.read<ProjectCubit>();
    if (cubit.state.segmentos == null) {
      final list = await cubit.getlistSegs();
      setState(() {
        _listSegmentos = list;
      });
    } else {
      setState(() {
        _listSegmentos = cubit.state.segmentos!;
      });
    }
    if (cubit.state.teses == null) {
      final list = await cubit.getlistTese();
      setState(() {
        _listTeses = list;
      });
    } else {
      setState(() {
        _listTeses = cubit.state.teses!;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.surfaceColor,
      floatingActionButton: CustomFloatButton(
        alignment: MainAxisAlignment.end,
        buttons: [
          FloatButton(
            label: 'Adicionar Segmento',
            icon: Icons.add,
            backgroundColor: ThemeUtils.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              await SegmentoDialog.show(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: _cardSegs(context),
              ),
            ],
          );
        },
      ),
    );
  }

  _cardSegs(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    if (cubit.state.segmentos != _listSegmentos) {
      //atualiza a lista logo apos mudanças
      _listSegmentos = cubit.state.segmentos!;
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: _listSegmentos.length,
        itemBuilder: (context, index) {
          final seg = _listSegmentos[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _segEditDialog(context, seg);
                  });
            },
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
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
            ),
          );
        },
      ),
    );
  }

  _segEditDialog(BuildContext context, Segmento seg) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.surfaceColor,
      title: Text('${seg.nome}',
          style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Row(children: [
              Text(
                  'As teses apresentadas abaixo são referentes a este segmento.',
                  style: TextStyle())
            ]),
            const SizedBox(height: 10),
            _content(context, seg),
          ],
        ),
      ),
      actions: [
        _buttonSair(context),
        _buttonEditar(context, seg),
      ],
    );
  }

  Widget _content(BuildContext context, Segmento seg) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (seg.numTeses != null && seg.numTeses!.isNotEmpty) {
          final Map<String, dynamic> decoded = jsonDecode(seg.numTeses!);

          decoded.forEach((key, value) {
            final intKey = int.tryParse(key);
            if (intKey != null) {
              final List<int> values = value
                  .toString()
                  .split(',')
                  .map((e) => int.tryParse(e))
                  .whereType<int>()
                  .toList();

              _tesesDoSegmento[intKey] = values.toSet();
            }
          });
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                children: [1, 2, 3]
                    .map((docId) => _buildTeseList(docId, seg))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTeseList(int documentoId, Segmento seg) {
    final listTeses = _listTeses;
    final selectedIds = _tesesDoSegmento[documentoId] ?? {};
    final selectedTeses =
        listTeses.where((tese) => selectedIds.contains(tese.id)).toList();

    return selectedTeses.isEmpty
        ? const Center(child: Text('Nenhuma tese para este regime.'))
        : ListView.builder(
            itemCount: selectedTeses.length,
            itemBuilder: (context, index) {
              final tese = selectedTeses[index];

              return CardTeses(
                tese: tese,
                isLarge: false,
                onlyRead: true,
                value: true,
                onChanged: (value) {},
              );
            },
          );
  }

  String _tabTitle(int docId, String label) {
    return label;
  }

  Widget _buttonSair(BuildContext context) {
    return ButtonSec(
      label: 'Sair',
      labelColor: Colors.red,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }

  Widget _buttonEditar(BuildContext context, Segmento seg) {
    return ButtonSec(
      label: 'Editar Segmento',
      labelColor: ThemeUtils.primaryColor,
      onPressed: () async {
        Navigator.pop(context);
        await SegmentoDialog.show(context, seg: seg);
      },
    );
  }
}

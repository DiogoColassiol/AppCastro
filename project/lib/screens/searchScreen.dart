// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/card_InfosApi.dart';
import 'package:project/widgets/card_segAndRegime.dart';
import 'package:project/widgets/floatButton.dart';
import 'package:project/widgets/input_widget.dart';
import 'package:project/widgets/dialogs/searchApiDialog.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Segmento>> _listSegmentos;

  late final FocusNode _node;
  late TextEditingController _inputControler;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProjectCubit>();
    _listSegmentos = cubit.getlistSegs();

    _node = FocusNode();
    _inputControler = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_node);
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _inputControler.dispose();
    super.dispose();
  }

  double getScreenWidth(BuildContext context) {
    final size = (MediaQuery.of(context).size.width);
    return size >= 800 && size <= 1260 ? 4 : 7;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.surfaceColor,
      floatingActionButton: CustomFloatButton(
        alignment: MainAxisAlignment.end,
        buttons: [
          FloatButton(
            label: 'Limpar Campos',
            icon: Icons.delete,
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            onPressed: () async {
              final cubit = context.read<ProjectCubit>();
              await cubit.init();
            },
          ),
          FloatButton(
            label: 'Gerar Relatório',
            icon: Icons.search,
            backgroundColor: ThemeUtils.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              final cubit = context.read<ProjectCubit>();
              final hasErro = await cubit.trataErros(context);
              if (!hasErro) {
                Navigator.of(context).pushReplacementNamed('result');
              }
            },
          ),
          FloatButton(
            label: 'teste',
            icon: Icons.search,
            backgroundColor: ThemeUtils.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {},
          ),
        ],
      ),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Informe os dados abaixo para realizar a busca!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _cliente(),
                      const SizedBox(height: 20),
                      if (state.apiResult?.nome != null &&
                          state.apiResult?.fantasia != null &&
                          state.apiResult?.situacao != null)
                        _apiInfos(),
                      FutureBuilder<List<Segmento>>(
                        future: _listSegmentos,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Erro: ${snapshot.error}');
                          } else {
                            final segmentos = snapshot.data ?? [];
                            return _buildSegmentos(segmentos);
                          }
                        },
                      ),
                      _documentos(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _cliente() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size.width;
        final cubit = context.read<ProjectCubit>();

        final bool isSmallScreen = size < 1600;
        final int inputFlex = isSmallScreen ? 10 : 10;
        final int buttonFlex = isSmallScreen ? 3 : 1;

        return Row(
          children: [
            Expanded(
              flex: inputFlex,
              child: Input(
                label: 'Informe o nome do cliente',
                value: state.cliente,
                focusNode: _node,
                controller: _inputControler,
                onChanged: (value) {
                  cubit.setCliente(value);
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: buttonFlex,
              child: _iconApiButton(context),
            )
          ],
        );
      },
    );
  }

  Widget _apiInfos() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        final receita = cubit.searchApi();
        return CardApiInfos(receita: receita);
      },
    );
  }

  Widget _buildSegmentos(List<Segmento> segmentos) {
    final cubit = context.read<ProjectCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Segmentos',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: getScreenWidth(context),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: segmentos.map((segmento) {
            final isSelected = '${segmento.id}' == cubit.state.segmentoSelectId;

            return CardSegDoc(
              nome: segmento.nome ?? '',
              selecionado: isSelected,
              onChanged: (value) async {
                await cubit.selectSeg(segmento.id, value!);
              },
              keyTile: Key(segmento.id.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _documentos() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        final documentos =
            (loadDocumentos()).where((doc) => doc.id != 0).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Regimes Tributários',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: getScreenWidth(context),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              children: documentos.map((documento) {
                final isSelected = '${documento.id}' == state.documentoSelectId;
                return CardSegDoc(
                  nome: documento.nome.toString(),
                  selecionado: isSelected,
                  onChanged: (value) {
                    cubit.selectDoc(documento.id, value!);
                  },
                  keyTile: Key(documento.id.toString()),
                );
              }).toList(),
            )
          ],
        );
      },
    );
  }

  List<Documento> loadDocumentos() => [
        Documento(id: 0, nome: 'Outros'),
        Documento(id: 1, nome: 'Simples Nacional'),
        Documento(id: 2, nome: 'Lucro Presumido'),
        Documento(id: 3, nome: 'Lucro Real'),
      ];

  Widget _iconApiButton(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final hasApi = state.apiResult?.nome != null &&
            state.apiResult?.fantasia != null &&
            state.apiResult?.situacao != null;

        return !hasApi
            ? ButtonApp(
                onPressed: () async {
                  await ApiDialog.show(context);
                },
                text: 'Busca API',
                color: ThemeUtils.primaryColor,
                icon: Icons.add,
              )
            : _buttonDeleteApi(context);
      },
    );
  }

  Widget _buttonDeleteApi(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        return ButtonApp(
          onPressed: () async {
            await c.clearApiResult();
          },
          text: 'Remover API',
          textColor: Colors.red,
          color: Colors.white,
          icon: Icons.delete,
        );
      },
    );
  }
}

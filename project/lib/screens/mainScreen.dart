// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/screens/resultScreen.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/widgets/card_teses_widget.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/input_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final FocusNode _node;
  late TabController _tabController;
  late TextEditingController _inputControler;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _tabController = TabController(length: 2, vsync: this);
    _inputControler = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_node);
    });
  }

  double getScreenWidth(BuildContext context) {
    final size = (MediaQuery.of(context).size.width);
    return size >= 800 && size <= 1260 ? 3 : 7;
  }

  @override
  void dispose() {
    _node.dispose();
    _tabController.dispose();
    _inputControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: ThemeUtils.backgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'lib/images/logo1.png',
                height: 230,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          indicatorColor: ThemeUtils.primaryColor,
          labelColor: ThemeUtils.primaryColor,
          controller: _tabController,
          tabs: const [
            Tab(text: "Buscar Teses", icon: Icon(Icons.search)),
            Tab(text: "Lista de Teses", icon: Icon(Icons.list_alt_sharp)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildHome(), _listTeses()],
      ),
    );
  }

  Widget _buildHome() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Container(
                color: ThemeUtils.backgroundColor,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Informe os dados abaixo para realizar a busca!',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _cliente(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(children: [
                          _segmentos(),
                          // if (!state.segmentos!
                          //     .any((s) => s.id == '7' && s.selecionado!))
                          _documentos(),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: ThemeUtils.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buttonDelete(),
                    const SizedBox(width: 20),
                    _buttonSearch(),
                    const SizedBox(width: 20),
                    //   _hasObs()
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _cliente() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Input(
            label: 'Informe o nome do cliente',
            value: state.cliente,
            preffixIcon: const Icon(Icons.person),
            focusNode: _node,
            controller: _inputControler,
            onChanged: (value) {
              cubit.setCliente(value);
            },
          ),
        );
      },
    );
  }

  Widget _segmentos() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        final segmentos = state.segmentos ?? [];

        return Expanded(
          flex: 2,
          child: Column(
            children: [
              const Text('Segmentos',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: getScreenWidth(context),
                  padding: const EdgeInsets.all(8.0),
                  children: segmentos.map((segmento) {
                    return Card(
                      color: ThemeUtils.backgroundColor,
                      child: CheckboxListTile(
                        title: Text(
                          segmento.nome.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                        value: segmento.selecionado,
                        key: Key(segmento.id.toString()),
                        activeColor: ThemeUtils.primaryColor,
                        onChanged: (value) {
                          cubit.selectSeg(segmento.id, value);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _documentos() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final outros =
            !state.segmentos!.any((s) => s.id == '7' && s.selecionado!);
        final cubit = context.read<ProjectCubit>();
        final documentos = state.documentos ?? [];
        return Expanded(
          child: Column(
            children: [
              const Text('Regimes Tributários',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              outros
                  ? Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: getScreenWidth(context),
                        padding: const EdgeInsets.all(8.0),
                        children: documentos.map((documento) {
                          return Card(
                            color: ThemeUtils.backgroundColor,
                            child: CheckboxListTile(
                              title: Text(
                                documento.nome.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: documento.selecionado,
                              key: Key(documento.id.toString()),
                              activeColor: ThemeUtils.primaryColor,
                              onChanged: (value) {
                                cubit.selectDoc(documento.id, value);
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                          'Outros não é necessário informar o regime tributário!'),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _listTeses() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: state.teses!.length,
              itemBuilder: (context, index) {
                final teses = state.teses![index];
                return CardTeses(
                  id: teses.id,
                  desc: teses.descricao,
                  legenda: teses.legenda,
                );
              },
            )),
          ],
        );
      },
    );
  }

  Widget _buttonSearch() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return ButtonApp(
          text: 'Gerar Relatório',
          icon: Icons.search,
          textColor: Colors.white,
          color: ThemeUtils.primaryColor,
          onPressed: () async {
            final nome = await cubit.searchCliente();
            final segmento = await cubit.searchSeg();
            final documento = await cubit.searchDoc();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  nome: nome!,
                  segmento: segmento!,
                  documento: documento!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget _buttonRelGeral() {
  //   return BlocBuilder<ProjectCubit, ProjectState>(
  //     builder: (context, state) {
  //       final cubit = context.read<ProjectCubit>();
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ButtonApp(
  //           text: 'Rel. Geral',
  //           icon: Icons.search,
  //           textColor: Colors.white,
  //           color: ThemeUtils.primaryColor,
  //           onPressed: () async {
  //             await cubit.build(context);
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const ResultScreen()));
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buttonDelete() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return ButtonApp(
          text: 'Limpar Campos',
          icon: Icons.delete,
          textColor: Colors.red,
          color: Colors.white,
          // color: Colors.red,
          onPressed: () => cubit.delete(),
        );
      },
    );
  }
}

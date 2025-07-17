// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/alertDialogApp.dart';
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

  final List<Tese> teses = loadTesesDefault();
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
    return ListView.builder(
      itemCount: teses.length,
      itemBuilder: (context, index) {
        final tese = teses[index];
        final isSelected = _selectedTesesPorDocumento[documentoId]!
            .contains(int.parse(tese.id!));
        return CardTeses(
          id: tese.id,
          desc: tese.descricao,
          legenda: tese.docs,
          isLarge: false,
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedTesesPorDocumento[documentoId]!
                    .add(int.parse(tese.id!));
              } else {
                _selectedTesesPorDocumento[documentoId]!
                    .remove(int.parse(tese.id!));
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

  static List<Tese> loadTesesDefault() => [
        Tese(
          id: '1',
          docs: 'Certificado Digital',
          descricao:
              'PRODUTOS SOB O REGIME MONOFÁSICO OU CONCENTRADO DE PIS E COFINS E O ICMS ST NO SIMPLES NACIONAL',
          legenda: '''
  As Empresas optantes pelo Simples Nacional que comercializam mercadorias adquiridas sob os Regimes de Substituição Tributária de ICMS e Tributação Monofásica ou Concentrada do PIS e da COFINS, podem estar pagando a mais os tributos que compõem o Cálculo do Simples Nacional, tendo em vista que os Tributos que podem ser descontados ou compensados estão sendo pagos juntamente com o recolhimento do Simples Nacional em cada mês.

  Tributação Monofásica ou Concentrada diz respeito à Concentração do Pis e da Cofins em uma fase somente, ou seja, na Primeira Fase, como é o caso da Importação e do Fabricante. Nesta Fase é cobrado o tributo e a contribuição de toda a Cadeia até o Consumidor final.

  Trabalho: efetuar o levantamento e proceder a recuperação ou compensação das quantias pagas indevidamente ou a maior de PIS e COFINS, nos últimos 60 meses pela empresa (período de prescrição).

  Lei 10.147 de 2.000; Lei 10.485 de 2.002; Lei 10.833 de 2003
  ''',
        ),
        Tese(
          id: '2',
          docs: 'Certificado Digital, Balanço, DRE',
          descricao:
              'COMPENSAÇÃO DE PREJUÍZOS FISCAIS E BASE DE CÁLCULO NEGATIVA DA CONTRIBUIÇÃO SOCIAL',
          legenda: '''
  A Base de Cálculo Negativa da CSLL e o Prejuízo Fiscal, Compensáveis, para efeito de tributação da CSLL e do IRPJ, são aqueles apurados na Demonstração do Resultado Ajustado da CSLL (e-LACS) e na Demonstração do Lucro Real (e-LALUR) de determinado período (trimestral ou anual) e controlado na Parte B do Lalur, observados os procedimentos prescritos na Instrução Normativa RFB 1.700 de 2017 e na ECF – Escrituração Contábil e Fiscal.

  Trabalho: efetuar o controle da compensação dos prejuízos fiscais e identificar os possíveis prejuízos fiscais não utilizados.
  ''',
        ),
        Tese(
          id: '3',
          docs: 'Certificado Digital, DRE',
          descricao: 'RECUPERAÇÃO DE CRÉDITOS DE PIS E COFINS NÃO UTILIZADOS',
          legenda: '''
  As pessoas jurídicas sujeitas ao Regime Não Cumulativo da contribuição para o PIS-Pasep e da Cofins, poderão constituir e descontar Créditos das referidas contribuições em diversas situações, desde que previstas na legislação de regência.

  O conceito de Insumos para a Indústria e para a Prestação de Serviços tem sofrido entendimentos sobre seu alcance no âmbito operacional das empresas e avalizado pelo seu alargamento perante as esferas administrativas (Carf) e judicial.

  A Instrução Normativa RFB 2.121 de 2022 regulamentou as hipóteses e possibilidades de constituição destes Créditos, que deverão ser analisadas através de uma criteriosa avaliação dos documentos da Empresa, inclusive com a apropriação do crédito não aproveitado anteriormente.

  Trabalho: análise e levantamento dos Créditos não considerados na Base de Cálculo do Pis e da Cofins, para a recuperação das quantias pagas indevidamente ou a maior de PIS, COFINS.
  ''',
        ),
        Tese(
          id: '4',
          docs: 'Certificado Digital, DRE, Balancete',
          descricao:
              'RECUPERAÇÃO DE PIS E COFINS – EXCLUSÃO DO ICMS DA BASE DE CÁLCULO',
          legenda: '''
  Com base no julgamento do Recurso Extraordinário 574.706/MG, com Repercussão Geral (Tema 69), de 15 de março de 2017, em que o STF firmou entendimento de que o valor destacado a título de ICMS não compõe a base de cálculo para a incidência do PIS e da Cofins, porque é estranho ao conceito de faturamento, e, dessa forma, o contribuinte poderá buscar a restituição ou recuperação dos valores recolhidos a maior, dentro do prazo de até 5 anos (prescrição).

  Trabalho: análise dos códigos utilizáveis e cálculo dos valores das reduções que serão objetos da exclusão para recuperação do imposto, e adequação da tributação da empresa com o intuito de excluir da base de cálculo do PIS e da Cofins o ICMS, para as operações futuras.
  ''',
        ),
        Tese(
          id: '5',
          docs: 'Certificado Digital, DRE, Balancete',
          descricao:
              'RECUPERAÇÃO DE PIS E COFINS – EXCLUSÃO DO ICMS SUBSTITUIÇÃO TRIBUTÁRIA DA BASE DE CÁLCULO',
          legenda: '''
  A partir do Parecer SEI 4090 de 2024/MF, torna-se possível no âmbito administrativo, a exclusão do ICMS ST da base de cálculo do PIS e COFINS pelo Contribuinte Substituído no regime de substituição tributária progressiva.

  Tema 1125 STJ: "O ICMS-ST não compõe a base de cálculo da Contribuição ao PIS e da COFINS devidas pelo contribuinte substituído no regime de substituição tributária progressiva".

  Modulação dos efeitos da decisão a partir do julgamento do Tema 69 de Repercussão Geral (15/03/2017). (Possível a retificação para restituição ou compensação de valores dos últimos cinco anos - período prescricional - exceto para empresa com ação judicial).

  Trabalho: análise dos códigos utilizáveis e cálculo dos valores das reduções que serão objetos da exclusão para recuperação do imposto, e adequação da tributação da empresa com o intuito de excluir da base de cálculo do PIS e da Cofins o ICMS, para as operações futuras.
  ''',
        ),
        Tese(
          id: '6',
          docs: 'Certificado Digital, DRE, Balancete',
          descricao:
              'RECUPERAÇÃO DE PIS E COFINS – EXCLUSÃO DO DIFERENCIAL DE ALÍQUOTAS DO ICMS DEVIDO NAS VENDAS INTERESTADUAIS DA BASE DE CÁLCULO DE PIS E COFINS',
          legenda: '''
  Com a publicação do PARECER SEI Nº 71/2025/MF, torna-se possível no âmbito administrativo, a exclusão do ICMS - DIFAL da Base de Cálculo do PIS e da COFINS pelo contribuinte que realiza vendas interestaduais a consumidor final e que recolha o diferencial de alíquotas para o Estado de destino.

  Modulação dos efeitos da decisão a partir do julgamento do Tema 69 de Repercussão Geral (15/03/2017). Será possível a retificação e restituição de valores dos últimos cinco anos, exceto para empresa com ação judicial.

  Trabalho: análise dos códigos utilizáveis e cálculo dos valores das reduções que serão objetos da exclusão para recuperação do imposto, e adequação da tributação da empresa com o intuito de excluir da base de cálculo do PIS e da Cofins o ICMS, para as operações futuras.
  ''',
        ),
        Tese(
          id: '7',
          docs: 'Certificado Digital, Balanço, DRE',
          descricao:
              'SUBVENÇÕES PARA INVESTIMENTOS E DOAÇÕES RECEBIDAS DO PODER PÚBLICO – EXCLUSÃO NO IRPJ E CSLL',
          legenda: '''
  As subvenções para investimento, inclusive mediante isenção ou redução de impostos, concedidas como estímulo à implantação ou expansão de empreendimentos econômicos e as doações feitas pelo poder público não serão computadas na determinação do lucro real.
  ''',
        ),
        Tese(
          id: '8',
          docs: 'Certificado Digital, DRE',
          descricao:
              'RECUPERAÇÃO DE CONTRIBUIÇÕES PREVIDENCIÁRIAS PAGAS SOBRE VERBAS INDENIZATÓRIAS',
          legenda: '''
  Conforme dispõe a IN RFB 2.110 de 2022, art. 34, alguns valores não devem compor a base de cálculo das contribuições sociais previdenciárias.

  Consolidado pelo Poder Judiciário, em caráter de Recurso Repetitivo:
  - Auxílio-doença e Auxílio-acidente nos primeiros 15 dias
  - Aviso prévio indenizado
  - 1/3 constitucional e Férias Indenizadas

  Trabalho: levantamento e identificação dos valores recolhidos indevidamente ou a maior pela empresa.
  ''',
        ),
        Tese(
          id: '9',
          docs: 'Certificado Digital, DRE',
          descricao:
              'RECUPERAÇÃO DA CONTRIBUIÇÃO PREVIDENCIÁRIA RELATIVA AOS 11% DE INSS RETIDO NA FONTE NOS SERVIÇOS PRESTADOS POR TERCEIRIZADOS',
          legenda: '''
  Os contratos de prestação de serviço com cessão de mão de obra ficam sujeitos à retenção na fonte do percentual de 11% calculado sobre o valor bruto de cada Nota Fiscal ou Fatura de prestação de serviço, ficando o tomador do serviço (contratante) como responsável por esta retenção e seu recolhimento.

  A retenção na fonte do percentual de 11% é considerada como Antecipação das Contribuições apuradas com base na Folha de Salário das empresas, garantindo ao Prestador de Serviço (terceirizado) que sofreu a retenção o direito de compensar tais valores no momento de sua apuração mensal.

  Trabalho: efetuar o levantamento e proceder a recuperação ou compensação das quantias pagas indevidamente ou a maior de Contribuição, nos últimos 60 meses pela empresa (período de prescrição).
  ''',
        ),
      ];
}

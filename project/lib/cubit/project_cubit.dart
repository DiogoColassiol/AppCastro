// lib/features/todo/cubit/todo_cubit.dart
// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmento.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/entity/teses.dart';
import 'package:project/print/resumo_pdf.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(const ProjectState()) {
    init();
  }
  Future<void> init() async {
    loadSegmentos();
    loadDocumentos();
    loadTeses();
  }

  Future<void> selectSeg(String? segId, bool? select) async {
    final segmentos = state.segmentos;
    final seg = state.segmentos!.firstWhere((e) => e.id == segId);
    if (select == true) {
      for (final seg in segmentos!) {
        seg.selecionado = false;
      }
    }
    seg.selecionado = select;
    emit(state.copyWith(segmentos: [...state.segmentos!]));
    emit(state.copyWith(segmentoSelect: seg));
  }

  Future<void> selectDoc(String? docId, bool? select) async {
    final documentos = state.documentos;
    final doc = state.documentos!.firstWhere((e) => e.id == docId);
    if (select == true) {
      for (final doc in documentos!) {
        doc.selecionado = false;
      }
    }
    doc.selecionado = select;
    emit(state.copyWith(documentos: [...state.documentos!]));
    emit(state.copyWith(documentoSelect: doc));
  }

  Future<Result> build(BuildContext context) async {
    final cliente = await searchCliente();
    final segSelect = await searchSeg();
    final docSelect = await searchDoc();
    final erro = await trataErros(context, cliente, segSelect, docSelect);
    final tesesSelect = await searchTeses(segSelect!, docSelect!);
    final needDocs = await searchDocs(tesesSelect);

    return await _buildResult(
      cliente,
      segSelect,
      docSelect,
      tesesSelect,
      needDocs,
      erro,
    );
  }

  Future<void> delete() async {
    final resetSeg = state.segmentos!
        .map((seg) => seg.copyWith(selecionado: false))
        .toList();
    emit(state.copyWith(segmentos: resetSeg));

    final resetDoc = state.documentos!
        .map((doc) => doc.copyWith(selecionado: false))
        .toList();
    emit(state.copyWith(documentos: resetDoc));
    emit(state.copyWith(cliente: ''));
  }

  Future<bool> trataErros(BuildContext context, String? cliente, Segmento? doc,
      Documento? seg) async {
    if (cliente == null || cliente == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cliente não informado!'),
          content: const Text(
              'Por favor, adicione o nome do cliente para iniciar a busca!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
            ),
          ],
        ),
      );
      return true;
    }
    if (doc == null || seg == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro na escolha'),
          content: const Text(
              'Selecione um segmento ou um documento para iniciar a busca!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
            ),
          ],
        ),
      );
      return true;
    }
    if (doc.id == '1' && seg.id == '1') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Não contém Teses!'),
          content: const Text(
              'Transportadoras com Simples Nacional não tem teses consolidadas!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
            ),
          ],
        ),
      );
      return true;
    }
    return false;
  }

  Future<List<Tese>> separaTeses(String? tesesId) async {
    final listTeses = state.teses;
    final ids = tesesId!.split(',').map((id) => id.trim()).toList();
    final teses =
        listTeses?.where((tese) => ids.contains(tese.id)).toList() ?? [];
    return teses;
  }

  Future<void> setCliente(String text) async {
    emit(state.copyWith(cliente: text));
  }

  Future<String?> searchCliente() async {
    return state.cliente;
  }

  Future<Segmento?> searchSeg() async {
    final segmentos = state.segmentos;
    if (segmentos == null) return null;
    for (final segmento in segmentos) {
      if (segmento.selecionado == true) {
        return segmento;
      }
    }
    return null;
  }

  Future<Documento?> searchDoc() async {
    final documentos = state.documentos;
    if (documentos == null) return null;
    for (final documento in documentos) {
      if (documento.selecionado == true) {
        return documento;
      }
    }
    return null;
  }

  Future<List<String>> searchDocs(List<Tese> teses) async {
    List<String> docsNeed = [];

    for (final tese in teses) {
      final docs = tese.docs!
          .split(',')
          .map((doc) => doc.trim())
          .where((doc) => doc.isNotEmpty)
          .toList();

      docsNeed.addAll(docs);
    }
    return docsNeed.toSet().toList();
  }

  Future<Result> _buildResult(
      String? cliente,
      Segmento segmento,
      Documento documento,
      List<Tese> teses,
      List<String>? docs,
      bool? erro) async {
    final data = DateTime.now();
    return Result(
        cliente: cliente,
        segmento: segmento,
        documento: documento,
        teses: teses,
        docsNecessarios: docs,
        dataDoc: data,
        erro: erro);
  }

  Future<void> printResult(Result result) async {
    final resumoPdf = ResumoPdfUtil(result: result);
    resumoPdf.format = PdfPageFormat.a4;
    await resumoPdf.createResumoPDF();
  }

  Future<List<Tese>> searchTeses(Segmento segmento, Documento documento) async {
    List<Tese> teses = [];
    switch (segmento.id) {
      case '1': //Transportadoras
        if (documento.id == '1') {
          teses = await separaTeses('semtese');
        }
        if (documento.id == '2') {
          teses = await separaTeses('8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,7,8,9');
        }

      case '2': // Postos
        if (documento.id == '1') {
          teses = await separaTeses('1');
        }
        if (documento.id == '2') {
          teses = await separaTeses('4,5,6,8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,4,5,6,7,8,9');
        }

      case '3': //Supermercados
        if (documento.id == '1') {
          teses = await separaTeses('1');
        }
        if (documento.id == '2') {
          teses = await separaTeses('4,5,6,8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,4,5,6,7,8,9');
        }

      case '4': //Agro/Cerealistas
        if (documento.id == '1') {
          teses = await separaTeses('1');
        }
        if (documento.id == '2') {
          teses = await separaTeses('4,5,6,8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,4,5,6,7,8,9');
        }

      case '5': //Distribuidores de alimentos
        if (documento.id == '1') {
          teses = await separaTeses('1');
        }
        if (documento.id == '2') {
          teses = await separaTeses('4,5,6,8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,4,5,6,7,8,9');
        }

      case '6': // Hortifrutigrangeiros
        if (documento.id == '1') {
          teses = await separaTeses('1');
        }
        if (documento.id == '2') {
          teses = await separaTeses('4,5,6,8,9');
        }
        if (documento.id == '3') {
          teses = await separaTeses('2,3,4,5,6,7,8,9');
        }
    }
    emit(state.copyWith(tesesSelect: teses));
    return teses;
  }

  Future<void> loadTeses() async {
    final teses = [
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
    emit(state.copyWith(teses: teses));
  }

  Future<void> loadSegmentos() async {
    final segmentos = [
      Segmento(id: '1', nome: 'Transportadoras'),
      Segmento(id: '2', nome: 'Postos de Combustível'),
      Segmento(id: '3', nome: 'Supermercados'),
      Segmento(id: '4', nome: 'Agro/Cerealistas'),
      Segmento(id: '5', nome: 'Distribuidores de Alimentos'),
      Segmento(id: '6', nome: 'Hortifrutigranjeiros'),
    ];
    emit(state.copyWith(segmentos: segmentos));
  }

  Future<void> loadDocumentos() async {
    final docs = [
      Documento(id: '1', nome: 'Simples Nacional'),
      Documento(id: '2', nome: 'Lucro Presumido'),
      Documento(id: '3', nome: 'Lucro Real')
    ];
    emit(state.copyWith(documentos: docs));
  }
}

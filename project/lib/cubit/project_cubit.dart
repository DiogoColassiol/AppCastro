// lib/features/todo/cubit/todo_cubit.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/receita_store.dart';
import 'package:project/api/repositories/receita_repo.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentoss.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/print/resumo_pdf.dart';
import 'package:project/widgets/alertDialogApp.dart';

class ProjectCubit extends AbstractCubit<ProjectState> {
  late final ReceitaStore store;

  ProjectCubit() : super(const ProjectState()) {
    store =
        ReceitaStore(this, repository: ReceitaRepository(client: HttpClient()));
    init();
  }
  Future<void> init() async {
    await loadSegmentos();
    await loadDocumentos();
    await loadTeses();
  }

  Future<ReceitaModel?> getDadosClient() async {
    String cnpj = searchCliente();
    return store.getReceitas(cnpj);
  }

  Segmento? searchSeg() {
    final segmentos = state.segmentos;
    final id = state.segmentoSelectId;
    final seg = segmentos!.firstWhere((e) => e.id == id);
    return seg;
  }

  Documento? searchDoc() {
    final documentos = state.documentos;
    final id = state.documentoSelectId;
    final doc = documentos!.firstWhere((e) => e.id == id);
    return doc;
  }

  Future<void> selectSeg(int? segId, bool isSelected) async {
    final atual = state.segmentoSelectId;

    // Se o mesmo segmento foi clicado, desmarcar todos
    if (segId == atual) {
      final segmentosAtualizados = state.segmentos?.map((s) {
        return s.copyWith(selecionado: false);
      }).toList();

      emit(state.copyWith(
        segmentoSelectId: null,
        segmentos: segmentosAtualizados,
      ));
      return;
    }

    // Marca o segmento selecionado
    final segmentosAtualizados = state.segmentos?.map((s) {
      return s.copyWith(selecionado: s.id == segId);
    }).toList();

    emit(state.copyWith(
      segmentoSelectId: segId,
      segmentos: segmentosAtualizados,
    ));

    if (segId == 7) {
      await selectDoc(4, true);
    }
  }

  Future<void> selectDoc(int? docId, bool? select) async {
    final atual = state.documentoSelectId;

    // Se o mesmo documento foi clicado novamente, desmarcar todos
    if (atual == docId && select == false) {
      final documentosAtualizados = state.documentos?.map((d) {
        return d.copyWith(selecionado: false);
      }).toList();

      emit(state.copyWith(
        documentoSelectId: null,
        documentos: documentosAtualizados,
      ));
      return;
    }
    // Marca o documento selecionado e desmarca os demais
    final documentosAtualizados = state.documentos?.map((d) {
      return d.copyWith(selecionado: d.id == docId);
    }).toList();

    emit(state.copyWith(
      documentoSelectId: docId,
      documentos: documentosAtualizados,
    ));
  }

  Future<void> checkObs(bool value) async {
    emit(state.copyWith(hasObs: value));
  }

  Future<void> setObs(String value) async {
    emit(state.copyWith(obs: value));
  }

  Future<void> setReturnApi(ReceitaModel? model) async {
    emit(state.copyWith(apiResult: model));
  }

  Future<void> setHasApi(bool value) async {
    emit(state.copyWith(hasApi: value));
  }

  Future<void> delete() async {
    final segmentosLimpos =
        state.segmentos?.map((s) => s.copyWith(selecionado: false)).toList();
    final documentosLimpos =
        state.documentos?.map((d) => d.copyWith(selecionado: false)).toList();

    emit(state.copyWith(
      segmentoSelectId: null,
      documentoSelectId: null,
      segmentos: segmentosLimpos,
      documentos: documentosLimpos,
      cliente: '',
      obs: '',
      hasObs: false,
      apiResult: null,
      hasApi: false,
    ));
  }

  Future<bool> trataErros(BuildContext context) async {
    final cliente = searchCliente();
    final seg = searchSeg();
    final doc = searchDoc();

    if (cliente == '') {
      DialogApp.warning(context, 'Cliente não informado!',
          'Por favor, adicione o nome do cliente para iniciar a busca!');

      return true;
    }
    if (seg == null) {
      DialogApp.warning(context, 'Erro na escolha!',
          'Selecione um segmento para inciar a busca!');

      return true;
    }
    if (doc == null) {
      DialogApp.warning(context, 'Erro na escolha!',
          'Selecione um documento para iniciar a busca!');

      return true;
    }
    if (doc.id == 1 && seg.id == 1) {
      DialogApp.warning(context, 'Não contém Teses!',
          'Transportadoras com Simples Nacional não tem teses consolidadas!');
      return true;
    }

    return false;
  }

  List<Tese> separaTeses(String? tesesId) {
    final listTeses = state.teses;
    final ids = tesesId!.split(',').map((id) => id.trim()).toList();
    final teses =
        listTeses?.where((tese) => ids.contains(tese.id)).toList() ?? [];
    return teses;
  }

  Future<void> setCliente(String text) async {
    emit(state.copyWith(cliente: text));
  }

  String searchCliente() {
    return state.cliente!;
  }

  ReceitaModel? searchReceita() {
    return state.apiResult;
  }

  ReceitaModel? searchApi() {
    final api = state.apiResult;
    return api;
  }

  List<String> searchDocs(List<Tese> teses, bool allDocs) {
    List<String> docsNeed = [];

    if (teses.isEmpty && allDocs) {
      teses = separaTeses('1,2,3,4,5,6,7,8,9');
    }
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
    Segmento? segmento,
    Documento? documento,
    List<Tese>? teses,
    List<String>? docs,
    ReceitaModel? receita,
    String? obs,
  ) async {
    return Result(
      cliente: cliente,
      segmento: segmento,
      documento: documento,
      teses: teses,
      docsNecessarios: docs,
      receita: receita,
      obs: obs,
    );
  }

  Future<void> printResult(
      String nome, Segmento segmento, Documento documento) async {
    String? obs;
    state.hasObs && state.obs!.isNotEmpty ? obs = state.obs : '';

    if (segmento.id == 7 && documento.id == 4) {
      final docs = searchDocs([], true);
      final receita = searchReceita();
      final result =
          _buildResult(nome, segmento, documento, [], docs, receita, obs);
      emit(state.copyWith(result: await result));
      final resumoPdf = ResumoPdfUtil(result: await result);
      resumoPdf.format = PdfPageFormat.a4;
      await resumoPdf.createResumoOutrosPDF();
      return;
    }
    final teses = searchTeses(segmento.id!, documento.id!);
    final needDocs = searchDocs(teses, false);
    final receita = searchReceita();

    final result =
        _buildResult(nome, segmento, documento, teses, needDocs, receita, obs);
    emit(state.copyWith(result: await result));
    final resumoPdf = ResumoPdfUtil(result: await result);
    resumoPdf.format = PdfPageFormat.a4;
    await resumoPdf.createResumoPDF();
    return;
  }

  List<Tese> searchTeses(int segmentoId, int documentoId) {
    List<Tese> teses = [];
    switch (segmentoId) {
      case 1: //Transportadoras
        if (documentoId == 1) {
          teses = separaTeses('semtese');
        }
        if (documentoId == 2) {
          teses = separaTeses('8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,7,8,9');
        }

      case 2: // Postos
        if (documentoId == 1) {
          teses = separaTeses('1');
        }
        if (documentoId == 2) {
          teses = separaTeses('4,5,6,8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,4,5,6,7,8,9');
        }

      case 3: //Supermercados
        if (documentoId == 1) {
          teses = separaTeses('1');
        }
        if (documentoId == 2) {
          teses = separaTeses('4,5,6,8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,4,5,6,7,8,9');
        }

      case 4: //Agro/Cerealistas
        if (documentoId == 1) {
          teses = separaTeses('1');
        }
        if (documentoId == 2) {
          teses = separaTeses('4,5,6,8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,4,5,6,7,8,9');
        }

      case 5: //Distribuidores de alimentos
        if (documentoId == 1) {
          teses = separaTeses('1');
        }
        if (documentoId == 2) {
          teses = separaTeses('4,5,6,8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,4,5,6,7,8,9');
        }

      case 6: // Hortifrutigrangeiros
        if (documentoId == 1) {
          teses = separaTeses('1');
        }
        if (documentoId == 2) {
          teses = separaTeses('4,5,6,8,9');
        }
        if (documentoId == 3) {
          teses = separaTeses('2,3,4,5,6,7,8,9');
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
    //  addTesesDB(teses);
    emit(state.copyWith(teses: teses));
  }

  // Future<void> addTesesDB(List<Tese> teses) async {
  //   for (final tese in teses) {
  //     await teseDataBase.addTese(
  //         tese.id!, tese.docs!, tese.descricao!, tese.legenda!);
  //   }
  // }

  // Future<void> addSegmentoDB(List<Segmento> segmentos) async {
  //   for (final segmento in segmentos) {
  //     await segmentoDataBase.addSegmento(
  //         segmento.id!, segmento.nome!, segmento.selecionado!);
  //   }
  // }

  // Future<void> addRegimeDB(List<Documento> regimes) async {
  //   for (final regime in regimes) {
  //     await regimeDataBase.addRegime(
  //         regime.id!, regime.nome!, regime.selecionado!);
  //   }
  // }

  Future<void> loadSegmentos() async {
    final segmentos = [
      Segmento(id: 1, nome: 'Transportadoras'),
      Segmento(id: 2, nome: 'Postos de Combustível'),
      Segmento(id: 3, nome: 'Supermercados'),
      Segmento(id: 4, nome: 'Agro/Cerealistas'),
      Segmento(id: 5, nome: 'Distribuidores de Alimentos'),
      Segmento(id: 6, nome: 'Hortifrutigranjeiros'),
      Segmento(id: 7, nome: 'Outros')
    ];
    // await addSegmentoDB(segmentos);
    emit(state.copyWith(segmentos: segmentos));
  }

  Future<void> loadDocumentos() async {
    final docs = [
      Documento(id: 1, nome: 'Simples Nacional'),
      Documento(id: 2, nome: 'Lucro Presumido'),
      Documento(id: 3, nome: 'Lucro Real'),
      Documento(id: 4, nome: 'Outros')
    ];
    // await addRegimeDB(docs);
    emit(state.copyWith(documentos: docs));
  }
}

// lib/features/todo/cubit/todo_cubit.dart
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/receita_store.dart';
import 'package:project/api/repositories/receita_repo.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/print/resumo_pdf.dart';
import 'package:project/widgets/alertBar.dart';
import 'package:project/widgets/alertDialogApp.dart';

class ProjectCubit extends AbstractCubit<ProjectState> {
  late final ReceitaStore store;

  ProjectCubit() : super(const ProjectState()) {
    store =
        ReceitaStore(this, repository: ReceitaRepository(client: HttpClient()));
    init();
  }
  Future<void> init() async {
    emit(ProjectState.initialState());
  }

  Future<ReceitaModel?> getDadosClient(BuildContext context) async {
    String cnpj = searchClienteCnpj();
    final json = await store.getReceitas(context, cnpj);
    final Map<String, dynamic> body = jsonDecode(json);
    if (body.values.first == 'ERROR') {
      Alertbar.showError(context,
          'CNPJ inválido ou não encontrado, verifique e tente novamente!');
      return null;
    } else {
      Alertbar.showSuccess(context, 'Consulta realizada com sucesso!');
      final ReceitaModel receita = ReceitaModel.fromMap(body);
      return receita;
    }
  }

  Segmento? searchSeg() {
    final segmentos = state.segmentos;
    final id = state.segmentoSelectId;
    if (id == null) {
      return null;
    }
    final seg = segmentos!.firstWhere((e) => e.id == id);
    return seg;
  }

  Documento? searchDoc() {
    final documentos = state.documentos;
    final id = state.documentoSelectId;
    if (id == null) {
      return null;
    }
    final doc = documentos!.firstWhere((e) => e.id == id);
    return doc;
  }

  Future<void> selectSeg(int? segId, bool isSelected) async {
    final segmentosAtualizados = state.segmentos?.map((s) {
      if (s.id == segId) {
        return s.copyWith(selecionado: isSelected);
      } else {
        return s.copyWith(selecionado: false);
      }
    }).toList();

    emit(state.copyWith(
      segmentoSelectId: isSelected ? segId : null,
      segmentos: segmentosAtualizados,
    ));

    if (isSelected && segId == 7) {
      await selectDoc(4, true);
    }
  }

  Future<void> selectDoc(int? docId, bool select) async {
    final documentosAtualizados = state.documentos?.map((d) {
      if (d.id == docId) {
        return d.copyWith(selecionado: select);
      } else {
        return d.copyWith(selecionado: false);
      }
    }).toList();

    emit(state.copyWith(
      documentoSelectId: select ? docId : null,
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

  Future<void> clearApiResult() async {
    emit(state.copyWith(
      clienteCnpj: '',
      apiResult: ReceitaModel(
          nome: null, fantasia: null, abertura: null, situacao: null),
    ));
  }

  Future<void> initialState() async {
    emit(ProjectState.initialState());
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
    if (seg!.selecionado == false) {
      DialogApp.warning(context, 'Erro na escolha!',
          'Selecione um segmento para inciar a busca!');

      return true;
    }
    if (doc!.selecionado == false) {
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

  Future<void> setClienteCnpj(String? text) async {
    emit(state.copyWith(clienteCnpj: text));
  }

  String searchClienteCnpj() {
    return state.clienteCnpj!;
  }

  String searchCliente() {
    return state.cliente!;
  }

  ReceitaModel? searchReceita() {
    return state.apiResult;
  }

  ReceitaModel? searchApi() {
    final api = state.apiResult;
    if (api == null) {
      return ReceitaModel(
          nome: null, abertura: null, fantasia: null, situacao: null);
    }
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
}

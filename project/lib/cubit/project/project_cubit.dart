// lib/features/todo/cubit/todo_cubit.dart
// ignore_for_file: use_build_context_synchronously, collection_methods_unrelated_type

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/receita_store.dart';
import 'package:project/api/repositories/receita_repo.dart';
import 'package:project/database/firedb.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/enum/teseTypeEnum.dart';
import 'package:project/print/resumo_pdf.dart';
import 'package:project/utils/string_utils.dart';
import 'package:project/widgets/alertBar.dart';
import 'package:project/widgets/dialogs/alertDialogApp.dart';

class ProjectCubit extends AbstractCubit<ProjectState> {
  final FirestoreDB firestoreDB;
  late final ReceitaStore store;

  ProjectCubit(this.firestoreDB) : super(const ProjectState()) {
    store = ReceitaStore(
      this,
      repository: ReceitaRepository(client: HttpClient()),
    );

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
    if (id == '' || id == null) {
      return null;
    }
    final seg = segmentos!.firstWhere((e) => "${e.id}" == id);
    return seg;
  }

  Documento? searchDoc() {
    final documentos = state.documentos;
    final id = state.documentoSelectId;
    if (id == '' || id == null) {
      return null;
    }
    final doc = documentos!.firstWhere((e) => '${e.id}' == id);
    return doc;
  }

  Future<void> selectSeg(int? ide, bool isSelected) async {
    final id = StringUtils.intToString(ide);
    emit(state.copyWith(
      segmentoSelectId: isSelected ? id : '',
    ));
    if (ide == 0) {
      await selectDoc(0, true);
    }
  }

  Future<void> selectDoc(int? docId, bool select) async {
    final id = StringUtils.intToString(docId);
    emit(state.copyWith(documentoSelectId: select ? id : ''));
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

  Future<bool> trataErros(BuildContext context) async {
    final cliente = searchCliente();
    final seg = searchSeg();
    final doc = searchDoc();
    final api = searchApi();

    if (cliente == '' && api!.nome == null) {
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

  List<Tese> separaTesesNew(Segmento seg, Documento doc) {
    //final tesesRepo = tesesDAO.tesesList;
    final numTeses = obterTesesPorDocumento(seg.numTeses!, doc.id!);
    //numero das tese chegando certo
    final listTesesEscolha = state.teses!.where((tese) {
      return tese.id != null && numTeses.contains(tese.id);
    }).toList();

    return listTesesEscolha;
  }

  List<int> obterTesesPorDocumento(String numTesesJson, int docId) {
    final id = StringUtils.intToString(docId);
    final Map<String, dynamic> decoded = Map<String, dynamic>.from(
      jsonDecode(numTesesJson),
    );
    final String? numerosTeses = decoded[id];
    if (numerosTeses == null || numerosTeses.trim().isEmpty) {
      return [];
    }
    return numerosTeses
        .split(',')
        .map((t) => int.tryParse(t.trim()))
        .where((t) => t != null)
        .cast<int>()
        .toList();
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

  List<String> searchDocs(List<Tese> teses) {
    List<String> docsNeed = [];
    if (teses.isEmpty) {
      return ["Certificado Digital", "Balanço", "DRE", "Balancete"];
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

  Future<void> printResult(String nome, Segmento segmento, Documento documento,
      List<Tese> teses, List<String> docs, ReceitaModel receita) async {
    String? obs;
    state.hasObs && state.obs!.isNotEmpty ? obs = state.obs : '';

    if (segmento.id == 0 && documento.id == 0) {
      final result =
          _buildResult(nome, segmento, documento, [], docs, receita, obs);
      emit(state.copyWith(result: await result));
      final resumoPdf = ResumoPdfUtil(result: await result);
      resumoPdf.format = PdfPageFormat.a4;
      await resumoPdf.createResumoOutrosPDF();
      return;
    }

    final result =
        _buildResult(nome, segmento, documento, teses, docs, receita, obs);
    emit(state.copyWith(result: await result));
    final resumoPdf = ResumoPdfUtil(result: await result);
    resumoPdf.format = PdfPageFormat.a4;
    await resumoPdf.createResumoPDF();
    return;
  }

/////////////////////////////////////////////////////////////////////////////
  Future<void> setSegmentoEdit(Segmento seg) async {
    emit(state.copyWith(editSegmento: seg));
  }

  Future<void> setSegmentoNome(String? value) async {
    emit(state.copyWith(segmentoNome: value));
  }

  Future<({bool hasError, String? message})> trataErrosEditSeg(
      Map<int, Set<int>> escolhas) async {
    final nome = searchNome();

    if (nome == null || nome.isEmpty) {
      return (
        hasError: true,
        message: 'O nome do segmento não pode estar vazio.'
      );
    }

    return (hasError: false, message: null);
  }

  ///////////////////// TESES ///////////////////////

  Future<void> setTeseDesc(String nome) async {}
  Future<void> setTeseLegenda(String legenda) async {}
  Future<void> addTese(TeseTypeEnum? tipo, Set<String> docs) async {}

  String? searchNome() {
    return state.segmentoNome;
  }

  // monta o json das teses do segmento
  Future<Map<String, String>> montarJsonTeses(
      Map<int, Set<int>> escolhas) async {
    final Map<String, String> map = {};
    escolhas.forEach((docId, teses) {
      final ordenadas = teses.toList()..sort();
      map[docId.toString()] = ordenadas.join(',');
    });

    return map;
  }

  Future<List<Documento>> loadDocumentos() async {
    List<Documento> listDoc = [
      Documento(id: 0, nome: 'Outros'),
      Documento(id: 1, nome: 'Simples Nacional'),
      Documento(id: 2, nome: 'Lucro Presumido'),
      Documento(id: 3, nome: 'Lucro Real'),
    ];
    emit(state.copyWith(documentos: listDoc));
    return listDoc;
  }
  /////////////////////////////// FIREBASE DATABASE ///////////////////////////////

//converte o map do db em lista de segmento/tese
  List<Segmento> createListSegs(List<Map<String, dynamic>> data) {
    return data.map((map) => Segmento.fromMap(map)).toList();
  }

  List<Tese> createListTese(List<Map<String, dynamic>> data) {
    return data.map((map) => Tese.fromMap(map)).toList();
  }

  Future<List<Segmento>> getlistSegs() async {
    var segs = await firestoreDB.getSegmentos();
    var segsList = createListSegs(segs);
    emit(state.copyWith(segmentos: segsList));
    return segsList;
  }

  Future<List<Tese>> getlistTese() async {
    var teses = await firestoreDB.getTeses();
    var tesesList = createListTese(teses);
    emit(state.copyWith(teses: tesesList));
    return tesesList;
  }

  Future<void> addSegmento({required Map<int, Set<int>> numTesesJson}) async {
    final segId = await firestoreDB.getMaxSegmentoId();
    final nome = searchNome();
    final jsonMap = await montarJsonTeses(numTesesJson);
    final jsonTeses = jsonEncode(jsonMap);

    final newSegmento = Segmento(
      id: segId + 1,
      nome: nome,
      numTeses: jsonTeses,
    );
    await firestoreDB.addSegmento(newSegmento);
    await getlistSegs();
  }

  Future<void> deleteSegmento(Segmento seg) async {
    await firestoreDB.deleteSegmento(seg);
    await getlistSegs();
  }

  Future<void> updateSegmentoComTeses(
      {required Map<int, Set<int>> numTesesJson, Segmento? seg}) async {
    final nome = searchNome();
    final jsonMap = await montarJsonTeses(numTesesJson);
    final jsonString = jsonEncode(jsonMap);

    final updateSegmento = Segmento(
      id: seg!.id,
      nome: nome,
      numTeses: jsonString,
    );
    await firestoreDB.updateSegmento(updateSegmento);
    await getlistSegs();
  }
}

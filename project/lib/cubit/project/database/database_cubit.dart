import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:project/repositories/segmentoDAO.dart';
import 'package:project/utils/string_utils.dart';
import 'package:project/widgets/alertDialogApp.dart';

class DbCubit extends AbstractCubit<DbState> {
  final SegmentoDAO segmentoDAO;

  DbCubit({
    required this.segmentoDAO,
  }) : super(const DbState()) {
    //  init();
  }
  // Future<void> init() async {
  //   final a= regimeDAO.getRegimes();
  //   emit(state.listRazao = regimeDAO.getRegimes())
  // }
  Future<void> addSegmentoComTeses(
      {required String? nome, required String numTesesJson}) async {
    final segmento = SegmentoDB(nome: nome, numTeses: numTesesJson);
    await segmentoDAO.insertSegmento(segmento);
    DbState.initState();
  }

  Future<void> setSegmentoNome(String? value) async {
    emit(state.copyWith(segmentoNome: value));
  }

  Future<void> setTesesNacional(String? value) async {
    emit(state.copyWith(tesesNacional: value));
  }

  Future<void> setTesesPresumido(String? value) async {
    emit(state.copyWith(tesesPresumido: value));
  }

  Future<void> setTesesReal(String? value) async {
    emit(state.copyWith(tesesReal: value));
  }

  String montarJsonTeses() {
    final map = {
      '1': state.tesesNacional,
      '2': state.tesesPresumido,
      '3': state.tesesReal,
    };
    return jsonEncode(map);
  }

  String? searchNome() {
    return state.segmentoNome;
  }

  String? searchNacional() {
    return state.tesesNacional;
  }

  String? searchPresumido() {
    return state.tesesPresumido;
  }

  String? searchReal() {
    return state.tesesReal;
  }

  Future<bool> trataErros(BuildContext context) async {
    var nome = searchNome();
    var nacional = searchNacional();
    var presumido = searchPresumido();
    var real = searchReal();

    if (nome == null || nome == '') {
      DialogApp.warning(
          context, 'Nome não informado!', 'Informe um nome para o segmento!');

      return true;
    }
    if (nacional == null || nacional == '') {
      DialogApp.warning(context, 'Teses nao informadas!',
          'Informe uma as teses para o regime Simples Nacional!');

      return true;
    }
    if (presumido == null || presumido == '') {
      DialogApp.warning(context, 'Teses nao informadas!',
          'Informe uma as teses para o regime Lucro Presumido!');

      return true;
    }
    if (real == null || real == '') {
      DialogApp.warning(context, 'Teses nao informadas!',
          'Informe uma as teses para o regime Lucro Real!');

      return true;
    }
    addSegmentoComTeses(nome: nome, numTesesJson: montarJsonTeses());
    return false;
  }

  Future<void> removeSegmento(BuildContext context) async {
    var id = StringUtils.stringToInt(state.segmentoId);
    await segmentoDAO.deleteSegmento(id!);
  }

  SegmentoDB buildSegmentoDB(Segmento doc) {
    return SegmentoDB(id: doc.id, nome: doc.nome);
  }

  Segmento buildSegmento(String? id, String? nome) {
    return Segmento(
      id: StringUtils.stringToInt(id),
      nome: nome,
      selecionado: null,
    );
  }

  // List<Tese> searchTesess(SegmentoDB segmento, int documentoId) {
  //   final teseStr = segmento.getTesesParaDocumento(documentoId);
  //   final teses = separaTeses(teseStr);
  //   return teses;
  // }
}

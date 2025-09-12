import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/enum/teseTypeEnum.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:project/models/teses_model.dart';
import 'package:project/repositories/segmentoDAO.dart';
import 'package:project/repositories/tesesDAO.dart';

class DbCubit extends AbstractCubit<DbState> {
  final SegmentoDAO segmentoDAO;
  final TesesDAO tesesDAO;

  DbCubit({
    required this.segmentoDAO,
    required this.tesesDAO,
  }) : super(const DbState()) {
    segmentoDAO.segmentosNotifier.addListener(_onDbChange);
    tesesDAO.tesesNotifier.addListener(_onDbChange);

    init();
  }
  void _onDbChange() {
    final segmentosDb = segmentoDAO.segmentosNotifier.value;
    final segmentos = segmentosDb.map(Segmento.fromDB).toList();
    emit(state.copyWith(listSegmentos: segmentos));

    final tesesDb = tesesDAO.tesesNotifier.value;
    final teses = tesesDb.map(Tese.fromDB).toList();
    emit(state.copyWith(listTeses: teses));
  }

  Future<void> init() async {
    await sinc();
  }

  Future<void> sinc() async {
    final segmentos = segmentoDAO.segmentosNotifier.value;
    final teses = tesesDAO.tesesNotifier.value;
    final state = await DbState.fromDB(segmentos, teses);
    emit(state);
  }

  Future<void> addSegmentoComTeses(
      {required Map<int, Set<int>> numTesesJson}) async {
    final nome = searchNome();
    final jsonMap = await montarJsonTeses(numTesesJson);
    final jsonString = jsonEncode(jsonMap);

    final segmento = SegmentoDB(
      nome: nome,
      codigo: await segmentoDAO.getMaiorCod() + 1,
      numTeses: jsonString,
    );

    await segmentoDAO.insertSegmento(segmento);
    await setSegmentoNome('');
  }

  Future<void> updateSegmentoComTeses(
      {required Map<int, Set<int>> numTesesJson, Segmento? seg}) async {
    final nome = searchNome();
    final jsonMap = await montarJsonTeses(numTesesJson);
    final jsonString = jsonEncode(jsonMap);

    final updateSegmento = SegmentoDB(
      nome: nome,
      codigo: seg!.id,
      numTeses: jsonString,
    );
    await segmentoDAO.updateSegmento(updateSegmento);
    await setSegmentoNome('');
  }

  Future<void> setSegmentoNome(String? value) async {
    emit(state.copyWith(segmentoNome: value));
  }

  Future<void> setSegmentoEdit(Segmento seg) async {
    emit(state.copyWith(editSegmento: seg));
  }

  String? searchNome() {
    return state.segmentoNome;
  }

  Future<Map<String, String>> montarJsonTeses(
      Map<int, Set<int>> escolhas) async {
    final Map<String, String> map = {};
    escolhas.forEach((docId, teses) {
      final ordenadas = teses.toList()..sort();
      map[docId.toString()] = ordenadas.join(',');
    });

    return map;
  }

  Future<({bool hasError, String? message})> trataErros(
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

  Future<void> removeSegmento(Segmento seg, BuildContext context) async {
    await segmentoDAO.deleteSegmento(seg.id!);
  }

  ///////////////////// TESES ///////////////////////

  Future<void> setTeseDesc(String nome) async {}
  Future<void> setTeseLegenda(String legenda) async {}
  Future<void> addTese(TeseTypeEnum? tipo, Set<String> docs) async {
    final nome = searchNomeTese();
    // final type = tipo!.index;

    final tese = TesesDB(
      descricao: nome,
      legenda: '',
      tipo: null,
      documentos: '',
      codigo: await tesesDAO.getMaiorCod(),
    );
    await tesesDAO.insertTese(tese);
    await setTeseDesc('');
    await setTeseLegenda('');
  }

  String? searchNomeTese() {
    return state.teseNome;
  }
}

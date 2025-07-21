import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:project/repositories/segmentoDAO.dart';
import 'package:project/repositories/tesesDAO.dart';
import 'package:project/utils/string_utils.dart';

class DbCubit extends AbstractCubit<DbState> {
  final SegmentoDAO segmentoDAO;
  final TesesDAO tesesDAO;

  DbCubit({
    required this.segmentoDAO,
    required this.tesesDAO,
  }) : super(const DbState());

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
    DbState.initState();
  }

  Future<void> setSegmentoNome(String? value) async {
    emit(state.copyWith(segmentoNome: value));
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
    final nacional = escolhas[1]?.join(',') ?? '';
    final presumido = escolhas[2]?.join(',') ?? '';
    final real = escolhas[3]?.join(',') ?? '';

    if (nome == null || nome.isEmpty) {
      return (
        hasError: true,
        message: 'O nome do segmento não pode estar vazio.'
      );
    }
    if (nacional.isEmpty) {
      return (
        hasError: true,
        message:
            'Você deve selecionar pelo menos uma tese para o Simples Nacional.'
      );
    }
    if (presumido.isEmpty) {
      return (
        hasError: true,
        message:
            'Você deve selecionar pelo menos uma tese para o Lucro Presumido.'
      );
    }
    if (real.isEmpty) {
      return (
        hasError: true,
        message: 'Você deve selecionar pelo menos uma tese para o Lucro Real.'
      );
    }
    return (hasError: false, message: null);
  }

  Future<void> removeSegmento(SegmentoDB seg, BuildContext context) async {
    await segmentoDAO.deleteSegmento(seg.codigo!);
  }

  SegmentoDB buildSegmentoDB(Segmento doc) {
    return SegmentoDB(id: doc.id, nome: doc.nome);
  }

  // Segmento buildSegmento(String? id, String? nome) {
  //   return Segmento(
  //     id: StringUtils.stringToInt(id),
  //     nome: nome,
  //   );
  // }
}

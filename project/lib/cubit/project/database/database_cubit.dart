import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:project/repositories/segmentoDAO.dart';
import 'package:project/utils/string_utils.dart';

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
  Future<void> addSegmentoComTeses(BuildContext context,
      {required String nome, required String numTesesJson}) async {
    final segmento = SegmentoDB(nome: nome, numTeses: numTesesJson);
    await segmentoDAO.insertSegmento(segmento);
  }

  Future<void> setSegmentoID(String value) async {
    emit(state.copyWith(segmentoId: value));
  }

  Future<void> setSegmentoNome(String value) async {
    emit(state.copyWith(segmentoNome: value));
  }

  Future<void> addSegmento(BuildContext context) async {
    var id = state.segmentoId;
    var nome = state.segmentoNome;
    final newSegmento = buildSegmento(id, nome);
    final segmentoDB = buildSegmentoDB(newSegmento);
    await segmentoDAO.insertSegmento(segmentoDB);
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
}

import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/cubit/project/database/database_state.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/models/razoes_model.dart';
import 'package:project/repositories/regimeRepo.dart';
import 'package:project/utils/string_utils.dart';

class DbCubit extends AbstractCubit<DbState> {
  final RegimeDAO regimeDAO;

  DbCubit({
    required this.regimeDAO,
  }) : super(const DbState()) {
    //  init();
  }
  // Future<void> init() async {
  //   final a= regimeDAO.getRegimes();
  //   emit(state.listRazao = regimeDAO.getRegimes())
  // }

  Future<void> setRegimeID(String value) async {
    emit(state.copyWith(regimeId: value));
  }

  Future<void> setRegimeNome(String value) async {
    emit(state.copyWith(regimeNome: value));
  }

  Future<void> addRegime(BuildContext context) async {
    var id = state.regimeId;
    var nome = state.regimeNome;
    final newDocumento = buildDocumento(id, nome);
    final razao = buildRazao(newDocumento);
    await regimeDAO.insertRegime(razao);
  }

  Future<void> removeRegime(BuildContext context) async {
    var id = StringUtils.stringToInt(state.regimeId);
    await regimeDAO.deleteRegime(id!);
  }

  Razoes buildRazao(Documento doc) {
    return Razoes(documento: doc);
  }

  Documento buildDocumento(String? id, String? nome) {
    return Documento(
      id: StringUtils.stringToInt(id),
      nome: nome,
      selecionado: null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/api/http/exceptions.dart';
import 'package:project/api/repositories/receita_repo.dart';

class ReceitaStore {
  final IReceitaReposity repository;
  final AbstractCubit abstractCubit;

  ReceitaStore(this.abstractCubit, {required this.repository});

  Future<dynamic> getReceitas(BuildContext context, String cnpj) async {
    abstractCubit.setStateLoading();

    try {
      final result = await repository.getReceita(context, cnpj);
      abstractCubit.setStateSuccess('Busca Realizada com sucesso!');
      return result;
    } on NotFundException catch (e) {
      abstractCubit.setStateError(e.message);
      rethrow;
    } catch (e) {
      abstractCubit.setStateError(e.toString());
      rethrow;
    }
  }
}

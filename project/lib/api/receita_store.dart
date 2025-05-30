import 'package:flutter/material.dart';
import 'package:project/api/http/exceptions.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/repositories/receita_repo.dart';

class ReceitaStore {
  final IReceitaReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<ReceitaModel?> state = ValueNotifier<ReceitaModel?>(null);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ReceitaStore({required this.repository});

  Future<ReceitaModel> getReceitas(String cnpj) async {
    isLoading.value = true;

    try {
      final result = await repository.getReceita(cnpj);
      state.value = result;
    } on NotFundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
    return state.value!;
  }
}

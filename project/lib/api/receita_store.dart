import 'package:flutter/material.dart';
import 'package:project/api/http/exceptions.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/repositories/receita_repo.dart';

class ReceitaStore {
  final IReceitaReposity repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ReceitaModel>> state =
      ValueNotifier<List<ReceitaModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ReceitaStore({required this.repository});

  getReceitas() async {
    isLoading.value = true;

    try {
      final result = await repository.getReceita();
      state.value = result;
    } on NotFundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}

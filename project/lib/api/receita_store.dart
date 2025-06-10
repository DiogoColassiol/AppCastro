import 'package:project/abstract/abstract_cubit.dart';
import 'package:project/api/http/exceptions.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/api/repositories/receita_repo.dart';

class ReceitaStore {
  final IReceitaReposity repository;
  final AbstractCubit abstractCubit;

  ReceitaStore(this.abstractCubit, {required this.repository});

  Future<ReceitaModel> getReceitas(String cnpj) async {
    abstractCubit.setStateLoading();

    try {
      final result = await repository.getReceita(cnpj);
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

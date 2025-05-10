import 'dart:convert';

import 'package:project/api/http/exceptions.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/api/models/receita_model.dart';

abstract class IReceitaReposity {
  Future<List<ReceitaModel>> getReceita();
}

class ReceitaRepository implements IReceitaReposity {
  final IHttpClient client;

  ReceitaRepository({required this.client});
  @override
  Future<List<ReceitaModel>> getReceita() async {
    final response = await client.get(
      url: 'https://receitaws.com.br/v1/cnpj/{cnpj}',
    );
    if (response.statusCode == 200) {
      final List<ReceitaModel> receitaList = [];
      final body = jsonDecode(response.body);
      body['receitas'].map((it) {
        final ReceitaModel receita = ReceitaModel.fromMap(it);
        receitaList.add(receita);
      }).toList();
      return receitaList;
    } else if (response.statusCode == 404) {
      throw NotFundException('url informada nao é valida!');
    } else {
      throw NotFundException('nao foi possivel carregar a url');
    }
  }
}

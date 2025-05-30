import 'dart:convert';

import 'package:project/api/http/exceptions.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/api/models/receita_model.dart';

abstract class IReceitaReposity {
  Future<ReceitaModel> getReceita(String cnpj);
}

class ReceitaRepository implements IReceitaReposity {
  final IHttpClient client;

  ReceitaRepository({required this.client});
  @override
  Future<ReceitaModel> getReceita(String cnpj) async {
    final response =
        await client.get(url: 'https://receitaws.com.br/v1/cnpj/$cnpj');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final ReceitaModel receita = ReceitaModel.fromMap(body);
      return receita;
    } else if (response.statusCode == 404) {
      throw NotFundException('URL informada não é válida!');
    } else {
      throw NotFundException('Não foi possível carregar a URL.');
    }
  }
}

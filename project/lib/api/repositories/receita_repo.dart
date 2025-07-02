import 'package:flutter/material.dart';
import 'package:project/api/http/exceptions.dart';
import 'package:project/api/http/http_client.dart';
import 'package:project/widgets/alertBar.dart';

abstract class IReceitaReposity {
  Future<dynamic> getReceita(BuildContext context, String cnpj);
}

class ReceitaRepository implements IReceitaReposity {
  final IHttpClient client;

  ReceitaRepository({required this.client});
  @override
  Future<dynamic> getReceita(BuildContext context, String cnpj) async {
    final response =
        await client.get(url: 'https://receitaws.com.br/v1/cnpj/$cnpj');

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw NotFundException('URL informada não é válida!');
    } else if (response.statusCode == 429) {
      Alertbar.showWarning(context,
          'Limite de 3 consultas por minuto excedido, aguarde para consultar novamente!');
      throw NotFundException('Limite de buscas');
    } else {
      throw NotFundException('Não foi possível carregar a URL.');
    }
  }
}

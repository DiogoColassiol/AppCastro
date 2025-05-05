import 'package:project/entity/documentos.dart';
import 'package:project/entity/segmento.dart';
import 'package:project/entity/teses.dart';

class Result {
  final String? cliente;
  final Segmento? segmento;
  final Documento? documento;
  final List<Tese>? teses;
  final List<String>? docsNecessarios;
  final DateTime? dataDoc;
  final bool? erro;

  Result({
    this.cliente,
    this.segmento,
    this.documento,
    this.teses,
    this.docsNecessarios,
    this.dataDoc,
    this.erro = false,
  });

  Result copyWith({
    String? cliente,
    Segmento? segmento,
    Documento? documento,
    List<Tese>? teses,
    List<String>? docsNecessarios,
    DateTime? dataDoc,
    bool? erro,
  }) {
    return Result(
      cliente: cliente ?? this.cliente,
      segmento: segmento ?? this.segmento,
      documento: documento ?? this.documento,
      teses: teses ?? this.teses,
      docsNecessarios: docsNecessarios ?? docsNecessarios,
      dataDoc: dataDoc ?? this.dataDoc,
      erro: erro ?? this.erro,
    );
  }
}

import 'package:project/entity/documentos.dart';
import 'package:project/entity/segmentoss.dart';
import 'package:project/entity/tesess.dart';

class Result {
  final String? cliente;
  final Segmento? segmento;
  final Documento? documento;
  final List<Tese>? teses;
  final List<String>? docsNecessarios;
  final String? obs;

  Result({
    this.cliente,
    this.segmento,
    this.documento,
    this.teses,
    this.docsNecessarios,
    this.obs,
  });

  Result copyWith({
    String? cliente,
    Segmento? segmento,
    Documento? documento,
    List<Tese>? teses,
    List<String>? docsNecessarios,
    DateTime? dataDoc,
    String? obs,
    bool? erro,
  }) {
    return Result(
      cliente: cliente ?? this.cliente,
      segmento: segmento ?? this.segmento,
      documento: documento ?? this.documento,
      teses: teses ?? this.teses,
      docsNecessarios: docsNecessarios ?? docsNecessarios,
      obs: obs ?? this.obs,
    );
  }
}

import 'dart:convert';

import 'package:project/entity/segmentos.dart';

class SegmentoDB {
  final int? id;
  final int? codigo;
  final String? nome;
  final String? numTeses;

  SegmentoDB({this.id, this.codigo, this.nome, this.numTeses});

  factory SegmentoDB.fromSegmento(SegmentoDB segmento) {
    return SegmentoDB(
      id: segmento.id,
      codigo: segmento.codigo,
      nome: segmento.nome,
      numTeses: segmento.numTeses,
    );
  }
  Map<int, String> getTesesPorDocumento() {
    if (numTeses == null) return {};
    final Map<String, dynamic> decoded = jsonDecode(numTeses!);
    return decoded
        .map((key, value) => MapEntry(int.parse(key), value as String));
  }

  String getTesesParaDocumento(int documentoId) {
    final map = getTesesPorDocumento();
    return map[documentoId] ?? '';
  }

  Segmento toSegmento() {
    return Segmento(
      id: id,
      nome: nome,
      numTeses: numTeses,
    );
  }

  factory SegmentoDB.fromMap(Map<String, dynamic> map) {
    return SegmentoDB(
      id: map['id'],
      codigo: map['codigo'],
      nome: map['nome'],
      numTeses: map['numero_teses'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nome': nome,
      'numero_teses': numTeses,
    };
  }
}

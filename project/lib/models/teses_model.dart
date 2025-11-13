import 'package:project/entity/tesess.dart';

class TesesDB {
  final int? id;
  final int? codigo;
  final String? descricao;
  final String? legenda;
  final int? tipo;
  final String? documentos;

  TesesDB({
    this.id,
    this.codigo,
    this.descricao,
    this.legenda,
    this.tipo,
    this.documentos,
  });

  factory TesesDB.fromTeses(TesesDB tese) {
    return TesesDB(
      id: tese.id,
      codigo: tese.codigo,
      descricao: tese.descricao,
      legenda: tese.legenda,
      tipo: tese.tipo,
      documentos: tese.documentos,
    );
  }
  Tese toTeses() {
    return Tese(
      id: id,
      descricao: descricao,
      legenda: legenda,
      docs: documentos,
    );
  }

  factory TesesDB.fromMap(Map<String, dynamic> map) {
    return TesesDB(
        id: map['id'],
        descricao: map['descricao'],
        legenda: map['legenda'],
        documentos: map['documentos']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'legenda': legenda,
      'documentos': documentos
    };
  }
}

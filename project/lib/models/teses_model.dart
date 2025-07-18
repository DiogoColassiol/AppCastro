import 'package:project/entity/tesess.dart';

class TesesDB {
  final int? id;
  final int? codigo;
  final String? descricao;
  final String? legenda;
  final String? documentos;

  TesesDB(
      {this.id, this.codigo, this.descricao, this.legenda, this.documentos});

  factory TesesDB.fromTeses(TesesDB tese) {
    return TesesDB(
      id: tese.id,
      codigo: tese.codigo,
      descricao: tese.descricao,
      legenda: tese.legenda,
      documentos: tese.documentos,
    );
  }
  Tese toTeses() {
    return Tese(
      id: id,
      codigo: codigo,
      descricao: descricao,
      legenda: legenda,
      docs: documentos,
    );
  }

  factory TesesDB.fromMap(Map<String, dynamic> map) {
    return TesesDB(
        id: map['id'],
        codigo: map['codigo'],
        descricao: map['descricao'],
        legenda: map['legenda'],
        documentos: map['documentos']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descricao': descricao,
      'legenda': legenda,
      'documentos': documentos
    };
  }
}

import 'package:project/entity/documentos.dart';

class Segmento {
  final String? id;
  final String? nome;
  bool? selecionado;

  Segmento({
    this.id,
    this.nome,
    this.selecionado = false,
  });

  Segmento copyWith({
    String? id,
    String? nome,
    List<Documento>? docs,
    Segmento? segGerado,
    bool? selecionado,
  }) {
    return Segmento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      selecionado: selecionado ?? this.selecionado,
    );
  }
}

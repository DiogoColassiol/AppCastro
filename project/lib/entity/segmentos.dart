class Segmento {
  final int? id;
  final String? nome;
  final String? numTeses;
  bool? selecionado;

  Segmento({
    this.id,
    this.nome,
    this.numTeses,
    this.selecionado = false,
  });

  Segmento copyWith({
    int? id,
    String? nome,
    String? numTeses,
    bool? selecionado,
  }) {
    return Segmento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numTeses: numTeses ?? this.numTeses,
      selecionado: selecionado ?? this.selecionado,
    );
  }
}

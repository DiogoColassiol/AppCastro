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
    bool? selecionado,
  }) {
    return Segmento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      selecionado: selecionado ?? this.selecionado,
    );
  }
}

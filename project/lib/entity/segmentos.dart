class Segmento {
  final int? id;
  final String? nome;
  final String? numTeses;

  Segmento({
    this.id,
    this.nome,
    this.numTeses,
  });

  Segmento copyWith({
    int? id,
    String? nome,
    String? numTeses,
  }) {
    return Segmento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numTeses: numTeses ?? this.numTeses,
    );
  }

  // Construtor auxiliar para criar a partir de um Map
  factory Segmento.fromMap(Map<String, dynamic> map) {
    return Segmento(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      numTeses: map['numero_teses'] ?? 0,
    );
  }

  // Método opcional para converter de volta para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'numero_teses': numTeses,
    };
  }
}

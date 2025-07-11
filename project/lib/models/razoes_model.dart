import 'package:project/entity/documentos.dart';

class Razoes {
  Documento documento;
  Razoes({required this.documento});

  factory Razoes.fromMap(Map<String, dynamic> map) {
    return Razoes(
      documento: Documento(
        id: map['codigo'],
        nome: map['nome'],
      ),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'codigo': documento.id,
      'nome': documento.nome,
    };
  }
}

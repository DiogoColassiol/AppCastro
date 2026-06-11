import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmento.dart';
import 'package:project/entity/teses.dart';

class ProjectState {
  final String? cliente;
  final List<Segmento>? segmentos;
  final List<Documento>? documentos;
  final List<Tese>? teses;
  final Segmento? segmentoSelect;
  final Documento? documentoSelect;
  final List<Tese>? tesesSelect;
  final Result? result;
  // final bool? error;

  const ProjectState({
    this.cliente = '',
    this.segmentos,
    this.documentos,
    this.teses,
    this.segmentoSelect,
    this.documentoSelect,
    this.tesesSelect,
    this.result,
    // this.error,
  });

  ProjectState copyWith({
    String? cliente,
    List<Segmento>? segmentos,
    List<Documento>? documentos,
    Segmento? segmentoSelect,
    Documento? documentoSelect,
    List<Tese>? tesesSelect,
    List<Tese>? teses,
    Result? result,
  }) {
    return ProjectState(
      cliente: cliente ?? this.cliente,
      segmentos: segmentos ?? this.segmentos,
      documentos: documentos ?? this.documentos,
      teses: teses ?? this.teses,
      segmentoSelect: segmentoSelect ?? this.segmentoSelect,
      documentoSelect: documentoSelect ?? this.documentoSelect,
      tesesSelect: tesesSelect ?? this.tesesSelect,
      result: result ?? this.result,
    );
  }
}

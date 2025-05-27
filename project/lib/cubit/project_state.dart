import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentoss.dart';
import 'package:project/entity/tesess.dart';

class ProjectState {
  final String? cliente;
  final List<Segmento>? segmentos;
  final List<Documento>? documentos;
  final List<Tese>? teses;
  final Segmento? segmentoSelect;
  final Documento? documentoSelect;
  final List<Tese>? tesesSelect;
  final bool hasObs;
  final String? obs;
  final int? obsCount;
  final Result? result;
  //final String? errorMessage;

  const ProjectState({
    this.cliente = '',
    this.segmentos,
    this.documentos,
    this.teses,
    this.segmentoSelect,
    this.documentoSelect,
    this.tesesSelect,
    this.hasObs = false,
    this.obs = '',
    this.obsCount,
    this.result,
    // this.errorMessage = '',
  });

  ProjectState copyWith({
    String? cliente,
    List<Segmento>? segmentos,
    List<Documento>? documentos,
    Segmento? segmentoSelect,
    Documento? documentoSelect,
    List<Tese>? tesesSelect,
    List<Tese>? teses,
    bool? hasObs,
    String? obs,
    int? obsCount,
    Result? result,
    // String? errorMessage
  }) {
    return ProjectState(
      cliente: cliente ?? this.cliente,
      segmentos: segmentos ?? this.segmentos,
      documentos: documentos ?? this.documentos,
      teses: teses ?? this.teses,
      segmentoSelect: segmentoSelect ?? segmentoSelect,
      documentoSelect: documentoSelect ?? documentoSelect,
      tesesSelect: tesesSelect ?? this.tesesSelect,
      hasObs: hasObs ?? this.hasObs,
      obs: obs ?? this.obs,
      obsCount: obsCount ?? this.obsCount,
      result: result ?? this.result,
      //   errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

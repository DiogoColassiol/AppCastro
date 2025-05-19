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
  final bool hasObs;
  final String? obs;
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
    this.hasObs = false,
    this.obs = '',
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
    bool? hasObs,
    String? obs,
    Result? result,
    //  bool? error,
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
      result: result ?? this.result,
      //  error: error ?? this.error,
    );
  }
}
// import 'package:project/entity/documentos.dart';
// import 'package:project/entity/result.dart';
// import 'package:project/entity/segmento.dart';
// import 'package:project/entity/teses.dart';

// class ProjectState {
//   final Segmento? segmentoSelect;
//   final Documento? documentoSelect;
//   final List<Tese>? teses;
//   final Result? result;

//   const ProjectState({
//     this.segmentoSelect,
//     this.documentoSelect,
//     this.teses,
//     this.result,
//   });

//   ProjectState copyWith({
//     Segmento? segmentosSelect,
//     Documento? documentosSelect,
//     List<Tese>? teses,
//     Result? result,
//   }) {
//     return ProjectState(
//       segmentoSelect: segmentoSelect ?? segmentoSelect,
//       documentoSelect: documentoSelect ?? documentoSelect,
//       result: result ?? this.result,
//       teses: teses ?? this.teses,
//     );
//   }
// }

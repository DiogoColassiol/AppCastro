import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentoss.dart';
import 'package:project/entity/tesess.dart';

class ProjectState extends AbstractState {
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
  final ReceitaModel? apiResult;
  final bool hasApi;
  //final String? errorMessage;

  const ProjectState({
    super.state = const ActivityIdle(),
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
    this.apiResult,
    this.hasApi = false,
    // this.errorMessage = '',
  });
  @override
  List<Object?> get props => [
        super.state,
        cliente,
        segmentos,
        documentos,
        teses,
        segmentoSelect,
        documentoSelect,
        tesesSelect,
        hasObs,
        obs,
        obsCount,
        result,
        apiResult,
        hasApi
      ];

  @override
  ProjectState copyWith({
    ActivityState? state,
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
    ReceitaModel? apiResult,
    bool? hasApi,
    // String? errorMessage
  }) {
    return ProjectState(
      state: state ?? super.state,
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
      apiResult: apiResult ?? this.apiResult,
      hasApi: hasApi ?? this.hasApi,
      //   errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

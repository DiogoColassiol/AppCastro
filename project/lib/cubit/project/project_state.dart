import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/result.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/entity/tesess.dart';

class ProjectState extends AbstractState {
  final String? cliente;
  final String? clienteCnpj;
  final List<Segmento>? segmentos;
  final List<Documento>? documentos;
  final List<Tese>? teses;
  final String? segmentoSelectId;
  final String? documentoSelectId;
  final List<Tese>? tesesSelect;
  final bool hasObs;
  final String? obs;
  final int? obsCount;
  final Result? result;
  final ReceitaModel? apiResult;
//
  final List<Segmento>? listSegmentos;
  final List<Tese>? listTeses;
  final Segmento? editSegmento;
  final Tese? editTese;
  final String? segmentoId;
  final String? teseId;
  final String? segmentoNome;
  final String? teseNome;

  const ProjectState({
    super.state = const ActivityIdle(),
    this.cliente = '',
    this.clienteCnpj = '',
    this.segmentos,
    this.documentos,
    this.teses,
    this.segmentoSelectId = '',
    this.documentoSelectId,
    this.tesesSelect,
    this.hasObs = false,
    this.obs = '',
    this.obsCount,
    this.result,
    //
    this.apiResult,
    this.listSegmentos,
    this.listTeses,
    this.editSegmento,
    this.editTese,
    this.segmentoId,
    this.teseId,
    this.segmentoNome,
    this.teseNome,
  });

  @override
  List<Object?> get props => [
        super.state,
        cliente,
        clienteCnpj,
        segmentos,
        documentos,
        teses,
        segmentoSelectId,
        documentoSelectId,
        tesesSelect,
        hasObs,
        obs,
        obsCount,
        result,
        apiResult,
        //
        listSegmentos,
        listTeses,
        editSegmento,
        editTese,
        segmentoId,
        teseId,
        segmentoNome,
        teseNome,
      ];

  @override
  ProjectState copyWith({
    ActivityState? state,
    String? cliente,
    String? clienteCnpj,
    List<Segmento>? segmentos,
    List<Documento>? documentos,
    String? segmentoSelectId,
    String? documentoSelectId,
    List<Tese>? tesesSelect,
    List<Tese>? teses,
    bool? hasObs,
    String? obs,
    int? obsCount,
    Result? result,
    ReceitaModel? apiResult,
    //
    List<Segmento>? listSegmentos,
    List<Tese>? listTeses,
    Segmento? editSegmento,
    Tese? editTese,
    String? segmentoId,
    String? teseId,
    String? segmentoNome,
    String? teseNome,
  }) {
    return ProjectState(
      state: state ?? super.state,
      cliente: cliente ?? this.cliente,
      clienteCnpj: clienteCnpj ?? this.clienteCnpj,
      segmentos: segmentos ?? this.segmentos,
      documentos: documentos ?? this.documentos,
      teses: teses ?? this.teses,
      segmentoSelectId: segmentoSelectId ?? this.segmentoSelectId,
      documentoSelectId: documentoSelectId ?? this.documentoSelectId,
      tesesSelect: tesesSelect ?? this.tesesSelect,
      hasObs: hasObs ?? this.hasObs,
      obs: obs ?? this.obs,
      obsCount: obsCount ?? this.obsCount,
      result: result ?? this.result,
      apiResult: apiResult ?? this.apiResult,
      //
      listSegmentos: listSegmentos ?? this.listSegmentos,
      listTeses: listTeses ?? this.listTeses,
      editSegmento: editSegmento ?? this.editSegmento,
      editTese: editTese ?? this.editTese,
      segmentoId: segmentoId ?? this.segmentoId,
      teseId: teseId ?? this.teseId,
      segmentoNome: segmentoNome ?? this.segmentoNome,
      teseNome: teseNome ?? this.teseNome,
    );
  }

  static ProjectState initialState() {
    return ProjectState(
      state: const ActivityIdle(),
      cliente: '',
      clienteCnpj: '',
      segmentoSelectId: null,
      documentoSelectId: null,
      tesesSelect: null,
      hasObs: false,
      obs: '',
      obsCount: null,
      result: null,
      apiResult: ReceitaModel(
          nome: null, abertura: null, fantasia: null, situacao: null),
      //
      listSegmentos: null,
      listTeses: null,
      editSegmento: null,
      editTese: null,
      segmentoId: null,
      teseId: null,
      segmentoNome: '',
      teseNome: '',
    );
  }
}

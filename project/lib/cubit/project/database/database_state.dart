import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/models/segmentos_model.dart';
import 'package:project/models/teses_model.dart';

class DbState extends AbstractState {
  final List<Segmento>? listSegmentos;
  final List<Tese>? listTeses;
  final Segmento? editSegmento;
  final Tese? editTese;
  final String? segmentoId;
  final String? teseId;
  final String? segmentoNome;
  final String? teseNome;

  const DbState({
    super.state = const ActivityIdle(),
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
  DbState copyWith({
    ActivityState? state,
    List<Segmento>? listSegmentos,
    List<Tese>? listTeses,
    Segmento? editSegmento,
    Tese? editTese,
    String? segmentoId,
    String? teseId,
    String? segmentoNome,
    String? teseNome,
  }) {
    return DbState(
      state: state ?? super.state,
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

  static Future<DbState> fromDB(
      List<SegmentoDB> listSegmento, List<TesesDB> listTeses) async {
    final segmentos = listSegmento
        .map((s) => Segmento(
              id: s.codigo,
              nome: s.nome ?? '',
              numTeses: s.numTeses,
            ))
        .toList();

    final teses = listTeses
        .map((t) => Tese(
              id: t.codigo,
              descricao: t.descricao,
              legenda: t.legenda,
              tipo: t.tipo,
              docs: t.documentos,
            ))
        .toList();

    return DbState(
      listSegmentos: segmentos,
      listTeses: teses,
      segmentoId: '',
      segmentoNome: '',
      state: const ActivityIdle(),
    );
  }

  @override
  List<Object?> get props => [
        super.state,
        listSegmentos,
        listTeses,
        editSegmento,
        editTese,
        segmentoId,
        teseId,
        segmentoNome,
        teseNome,
      ];
}

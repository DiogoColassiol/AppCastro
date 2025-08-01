import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/entity/segmentos.dart';
import 'package:project/models/segmentos_model.dart';

class DbState extends AbstractState {
  final List<Segmento>? listSegmentos;
  final Segmento? editSegmento;
  final String? segmentoId;
  final String? segmentoNome;

  const DbState({
    super.state = const ActivityIdle(),
    this.listSegmentos,
    this.editSegmento,
    this.segmentoId,
    this.segmentoNome,
  });

  @override
  DbState copyWith({
    ActivityState? state,
    List<Segmento>? listSegmentos,
    Segmento? editSegmento,
    String? segmentoId,
    String? segmentoNome,
    String? tesesNacional,
    String? tesesPresumido,
    String? tesesReal,
  }) {
    return DbState(
      state: state ?? super.state,
      listSegmentos: listSegmentos ?? this.listSegmentos,
      editSegmento: editSegmento ?? this.editSegmento,
      segmentoId: segmentoId ?? this.segmentoId,
      segmentoNome: segmentoNome ?? this.segmentoNome,
    );
  }

  static Future<DbState> fromDB(List<SegmentoDB> listSegmento) async {
    final segmentos = listSegmento
        .map((s) => Segmento(
              id: s.codigo,
              nome: s.nome ?? '',
              numTeses: s.numTeses,
            ))
        .toList();

    return DbState(
      listSegmentos: segmentos,
      segmentoId: '',
      segmentoNome: '',
      state: const ActivityIdle(),
    );
  }

  @override
  List<Object?> get props => [
        super.state,
        listSegmentos,
        editSegmento,
        segmentoId,
        segmentoNome,
      ];
}

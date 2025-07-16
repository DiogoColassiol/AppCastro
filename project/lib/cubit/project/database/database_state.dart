import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/models/segmentos_model.dart';

class DbState extends AbstractState {
  final List<SegmentoDB>? listSegmentos;
  final String? segmentoId;
  final String? segmentoNome;
  final String tesesNacional;
  final String tesesPresumido;
  final String tesesReal;
  const DbState({
    super.state = const ActivityIdle(),
    this.listSegmentos,
    this.segmentoId,
    this.segmentoNome,
    this.tesesNacional = '',
    this.tesesPresumido = '',
    this.tesesReal = '',
  });

  @override
  DbState copyWith({
    ActivityState? state,
    List<SegmentoDB>? listSegmentos,
    String? segmentoId,
    String? segmentoNome,
    String? tesesNacional,
    String? tesesPresumido,
    String? tesesReal,
  }) {
    return DbState(
      state: state ?? super.state,
      listSegmentos: listSegmentos ?? this.listSegmentos,
      segmentoId: segmentoId ?? this.segmentoId,
      segmentoNome: segmentoNome ?? this.segmentoNome,
      tesesNacional: tesesNacional ?? this.tesesNacional,
      tesesPresumido: tesesPresumido ?? this.tesesPresumido,
      tesesReal: tesesReal ?? this.tesesReal,
    );
  }

  static DbState initState() {
    return const DbState(
      listSegmentos: [],
      segmentoId: '',
      segmentoNome: '',
      tesesNacional: '',
      tesesPresumido: '',
      tesesReal: '',
      state: ActivityIdle(),
    );
  }

  @override
  List<Object?> get props => [
        super.state,
        listSegmentos,
        segmentoId,
        segmentoNome,
        tesesNacional,
        tesesPresumido,
        tesesReal,
      ];
}

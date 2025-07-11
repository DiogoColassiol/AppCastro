import 'package:project/abstract/abstract_state.dart';
import 'package:project/abstract/activity_state.dart';
import 'package:project/models/razoes_model.dart';

class DbState extends AbstractState {
  final List<Razoes>? listRazao;
  final String? regimeId;
  final String? regimeNome;
  const DbState({
    super.state = const ActivityIdle(),
    this.listRazao,
    this.regimeId,
    this.regimeNome,
  });

  @override
  DbState copyWith({
    ActivityState? state,
    String? regimeId,
    String? regimeNome,
  }) {
    return DbState(
      state: state ?? super.state,
      regimeId: regimeId ?? this.regimeId,
      regimeNome: regimeNome ?? this.regimeNome,
    );
  }

  static DbState initState() {
    return const DbState(
      listRazao: [],
      regimeId: '',
      regimeNome: '',
      state: ActivityIdle(),
    );
  }

  @override
  List<Object?> get props => [
        super.state,
        listRazao,
        regimeId,
        regimeNome,
      ];
}

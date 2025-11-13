import 'package:equatable/equatable.dart';

class DbFireState extends Equatable {
  final bool loading;
  final List<Map<String, dynamic>> segmentos;
  final List<Map<String, dynamic>> teses;
  final String? error;

  const DbFireState({
    this.loading = false,
    this.segmentos = const [],
    this.teses = const [],
    this.error,
  });

  DbFireState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? segmentos,
    List<Map<String, dynamic>>? teses,
    String? error,
  }) {
    return DbFireState(
      loading: loading ?? this.loading,
      segmentos: segmentos ?? this.segmentos,
      teses: teses ?? this.teses,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, segmentos, teses, error];
}

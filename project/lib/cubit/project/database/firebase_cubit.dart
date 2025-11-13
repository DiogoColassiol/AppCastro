// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/cubit/project/database/database_fire_state.dart';
// import 'package:project/database/firedb.dart';

// class DbFirebaseCubit extends Cubit<DbFireState> {
//   final FirestoreDB firestoreDB;

//   DbFirebaseCubit(this.firestoreDB) : super(const DbFireState());

//   Future<void> fetchSegmentos() async {
//     emit(state.copyWith(loading: true));
//     try {
//       final data = await firestoreDB.getSegmentos();
//       emit(state.copyWith(segmentos: data, loading: false));
//     } catch (e) {
//       emit(state.copyWith(loading: false, error: e.toString()));
//     }
//   }

//   Future<void> addSegmento(Map<String, dynamic> segmento) async {
//     try {
//       await firestoreDB.addSegmento(segmento);
//       await fetchSegmentos();
//     } catch (e) {
//       emit(state.copyWith(error: e.toString()));
//     }
//   }
// }
